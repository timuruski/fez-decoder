require 'models/char'

describe Char do
  subject { Char.new(1, { 'a' => 1 }, { 'c' => 1 }) }
  its(:frequency) { should eq(1) }
  its(:after) { should eq({'a' => 1}) }
  its(:before) { should eq({'c' => 1}) }

  describe "adding" do
    it "can be added to another profile" do
      a = Char.new(1, { 'a' => 1 },
                             { 'b' => 1 })
      b = Char.new(1, { 'b' => 1 },
                             { 'c' => 1 })
      c = Char.new(2, { 'a' => 1, 'b' => 1 },
                             { 'b' => 1, 'c' => 1 })

      expect(a + b).to eq(c)
    end
  end
end
