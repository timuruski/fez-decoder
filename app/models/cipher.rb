require 'models/word'

class Cipher
  def initialize(name)
    @name = name
    @words = Hash.new
    @chars = char_hash
  end

  attr_reader :name

  # Public: Generate a hash containing the profile of all the letters
  # known and their profiles.
  #
  # The frequency of a character needs to be calculated against the
  # total number of characters seen in order to scale between languages.
  def profile
    @chars.dup
  end

  # Public: Add a word to the list of words for this language/encoding.
  def learn(text)
    words = text.split(' ').uniq
    words.each do |word|
      learn_word(word)
    end
  end


  protected


  # Internal
  def learn_word(word)
    word_profile = Word.new(word).profile
    # word_profile.each do |char, (f, a, b)|
    word_profile.each do |c, char|
      @chars[c] += char
    end

    @words[word] = word_profile
  end

  # Internal
  def char_hash
    Hash.new { |h,k|
      h[k] = Char.new(0, { }, { })
    }
  end


end
