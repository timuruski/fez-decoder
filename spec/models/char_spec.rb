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

  describe "comparison" do
    it "is equal when they have the same signature" do
      a = Char.new(1, { 'a' => 1 }, { 'b' => 1 })
      b = Char.new(1, { 'a' => 1 }, { 'b' => 1 })

      expect(a == b).to be_true
    end

    it "not equal when they differ in frequency" do
      a = Char.new(1, {}, {})
      b = Char.new(3, {}, {})

      expect(a == b).to be_false
    end

    it "not equal when they differ in after frequencies" do
      a = Char.new(1, { 'a' => 1 }, { 'b' => 1 })
      b = Char.new(1, { 'a' => 3 }, { 'b' => 1 })

      expect(a == b).to be_false
    end

    it "not equal when they differ in before frequencies" do
      a = Char.new(1, { 'a' => 1 }, { 'b' => 1 })
      b = Char.new(1, { 'a' => 1 }, { 'b' => 3 })

      expect(a == b).to be_false
    end
  end

  describe "to_ary" do
    it "can convert into an array" do
      subject = Char.new(1, { 'a' => 1 }, { 'b' => 1 })
      ary = [1, { 'a' => 1 }, { 'b' => 1 }]

      expect(subject.to_ary).to eql(ary)
    end
  end
end
