require 'models/profiler'
require 'models/char'

describe Profiler do
  subject { Profiler.new('English') }
  its(:name) { should eq('English') }

  context "given a stream of text" do
    it "builds a profile of each character" do
      foo_profile = {
        'f' => Char.new(1, { '' => 1 },
                           { 'o' => 1 }),
        'o' => Char.new(2, { 'f' => 1, 'o' => 1 },
                           { 'o' => 1, '' => 1 }),
        'b' => Char.new(1, { '' => 1 },
                           { 'a' => 1 }),
        'a' => Char.new(1, { 'b' => 1 },
                           { 'r' => 1 }),
        'r' => Char.new(1, { 'a' => 1 },
                           { '' => 1 })
      }

      subject.learn('foo bar')
      expect(subject.profile).to eq(foo_profile)
    end

    it "keeps a list of words it has learned"
    it "filters duplicate words"
    it "handles upper and lower case letters"

  end
end
