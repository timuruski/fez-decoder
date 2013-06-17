class Char
  def initialize(frequency, after, before)
    @frequency = frequency
    @after = after
    @before = before
  end

  attr_reader :frequency

  # Public: Returns a copy of the after frequency hash.
  def after
    @after.dup
  end

  # Public: Returns a copy of the before frequency hash.
  def before
    @before.dup
  end

  # Public: Adds one profile to another.
  def +(other)
    f = frequency + other.frequency
    a = fold_hash(@after, other.after)
    b = fold_hash(@before, other.before)
    self.class.new(f, a, b)
  end


  def ==(other)
    frequency == other.frequency &&
      @after == other.after &&
      @before == other.before
  end


  protected

  def fold_hash(a, b)
    c = Hash.new { |h,k| h[k] = 0 }
    a.each_with_object(c) { |(k,v),c| c[k] += v }
    b.each_with_object(c) { |(k,v),c| c[k] += v }
  end

end
