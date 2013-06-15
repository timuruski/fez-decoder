require 'models/profiler'

describe Profiler do
  subject { Profiler.new('English') }
  its(:name) { should eq('English') }

  context "given a steam of text" do
    it "builds a profile of each character" do
      foo_profile = {
        'f' => { f: 1,
                 a: { '' => 1 },
                 b: { 'o' => 1 } },
        'o' => { f: 2,
                 a: { 'f' => 1, 'o' => 1 },
                 b: { 'o' => 1, '' => 1 } }
      }

      subject.learn('foo')
      expect(subject.profile).to eq(foo_profile)
    end

    it "keeps a list of words it has learned" do
      subject.learn('foo')
      subject.learn('bar')
    end

    it "filters duplicate words"
    it "handles upper and lower case letters"

  end
end
