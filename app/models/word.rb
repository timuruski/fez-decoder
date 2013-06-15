require 'forwardable'

class Word
  def initialize(raw)
    @raw = raw
    @character_frequency = build_character_frequency
    @character_pairs = build_character_pairs
  end

  attr_reader :character_frequency, :character_pairs

  extend Forwardable
  def_delegators :@raw, :chars,
                        :length,
                        :to_s


  # Public: Returns a hash profiling the characters in a word. For each
  # character in the hash another hash results. The hash contains:
  #   f: frequency of letter in a word
  #   a: frequency of letters coming after
  #   b: frequency of letters coming before
  def profile
    chars = @raw.chars
    chars.each_with_object(profile_hash).with_index do |(char, h), i|
      after = '' if i == 0
      after ||= chars[i - 1]

      before = chars[i + 1]
      before ||= ''

      char_profile = h[char]
      char_profile[:f] += 1
      char_profile[:a][after] += 1
      char_profile[:b][before] += 1
    end
  end

  private


  def profile_hash
    Hash.new { |h,k|
      h[k] = { f: 0,
               a: sum_hash,
               b: sum_hash
             } }
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
