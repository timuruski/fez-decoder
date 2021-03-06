require 'models/word'
require 'models/char'

describe Word do
  subject { Word.new('foobar') }

  it "has a raw value" do
    expect(subject.to_s).to eq('foobar')
  end

  it "has a length" do
    expect(subject.length).to eq(6)
  end

  describe "#profile" do
    it "can produce one as an array" do
      subject = Word.new('foo')
      foo_profile = {
        'f' => Char.new(1, { '' => 1 },
                           { 'o' => 1 }),
        'o' => Char.new(2, { 'f' => 1, 'o' => 1 },
                           { 'o' => 1, '' => 1 })
      }

      expect(subject.profile).to eq(foo_profile)
    end
  end

  it "has a hash of character frequencies" do
    foobar_freq = { 'f' => 1, 'o' => 2,
                    'b' => 1, 'a' => 1, 'r' => 1 }

    expect(subject.character_frequency).to eq(foobar_freq)
  end

  it "has an array of character pairs" do
    foobar_pairs = [' f', 'fo', 'oo', 'ob', 'ba', 'ar', 'r ']
    expect(subject.character_pairs).to eq(foobar_pairs)
  end
end
