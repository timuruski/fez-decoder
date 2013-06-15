class Profiler
  SUM_HASH = ->(h,k) { h[k] = 0 }

  def initialize(name)
    @name = name
    @words = Hash.new
    @profile = Hash.new { |h,k| h[k] = { f: 0,
                                         a: Hash.new(&SUM_HASH),
                                         b: Hash.new(&SUM_HASH) } }
  end

  attr_reader :name


  def profile
    @profile.dup
  end

  def learn(text)
    words = text.split(' ').uniq
    words.each do |word|
      learn_word(word)
    end
  end

  protected


  def learn_word(word)
    chars = word.chars
    chars.each_with_index do |char, i|
      after = '' if i == 0
      after ||= chars[i - 1]

      before = chars[i + 1]
      before ||= ''

      learn_char(char, after, before)
    end
  end

  def learn_char(char, after, before)
    char_profile = @profile[char]
    char_profile[:f] += 1
    char_profile[:a][after] += 1
    char_profile[:b][before] += 1
  end

end
