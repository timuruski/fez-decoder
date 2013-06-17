require 'forwardable'
require 'models/char'

class Word
  def initialize(raw)
    @raw = raw
    @character_frequency = build_character_frequency
    @character_pairs = build_character_pairs
    @profile = build_profile
  end

  attr_reader :character_frequency, :character_pairs, :profile

  extend Forwardable
  def_delegators :@raw, :chars,
                        :length,
                        :to_s


  private


  # Internal
  def build_profile
    chars = @raw.chars
    chars.each_with_object(profile_hash).with_index do |(c, h), i|
      after = '' if i == 0
      after ||= chars[i - 1]

      before = chars[i + 1]
      before ||= ''

      h[c] += build_char(after, before)
    end
  end

  # Internal
  def build_char(after, before)
    Char.new(1, { after => 1 }, { before => 1 })
  end

  # Internal
  def profile_hash
    Hash.new { |h,k|
      h[k] = Char.new(0, { }, { })
    }
  end

  def sum_hash
    Hash.new { |h,k| h[k] = 0 }
  end

  # Internal: Builds a hash of every character in the word and the
  # frequency at which it appears.
  #   eg. 'foobar' => { 'f': 1, 'o': 2, 'b': 1, 'a': 1, 'r': 1 }
  def build_character_frequency
    memo = Hash.new { |h,k| h[k] = 0 }
    chars.each_with_object(memo) { |char,memo|
      memo[char] += 1
    }
  end

  # Internal: Builds a list of each character pair in a word, including
  # the first and last character with an accompanying space.
  #   eg. 'foobar' => [' f', 'fo', 'oo', 'ob', 'ba', 'ar', 'r ']
  def build_character_pairs
    " #@raw ".chars
      .each_cons(2)
      .map(&:join)
  end
end
