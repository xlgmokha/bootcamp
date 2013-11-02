module Comparer
  def descending
    InverseComparer.new(self)
  end

  def then(other)
    CompositeComparer.new(self, other)
  end
end


class InverseComparer
  include Comparer

  def initialize(original)
    @original = original
  end

  def compare(x, y)
    @original.compare(x, y) * -1
  end
end

class CompositeComparer
  include Comparer

  def initialize(first, second)
    @first, @second = first, second
  end

  def compare(x, y)
    result = @first.compare(x,y)
    result == 0 ? @second.compare(x, y) : result
  end
end

class RankedComparer
  include Comparer

  def initialize(rankings)
    @rankings = rankings
  end

  def compare(x, y)
    @rankings.find_index(x.studio) <=> @rankings.find_index(y.studio)
  end
end