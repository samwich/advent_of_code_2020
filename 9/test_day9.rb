require 'test/unit'
require_relative 'decoder'

class TestDay9 < Test::Unit::TestCase

  def test_find_sum
    d = Decoder.new('./test_input', 5)
    entries = d.entries[0,5]
    sum = d.entries[5]
    assert_equal([25, 15], d.day1_2sum_with_map(entries, sum) )
    assert_equal([25, 15], d.find_two_sum(0,4,5) )
  end
  
  def test_find_problem
    d = Decoder.new('./test_input', 5)
    assert_equal 127, d.find_problem
  end
  
  def test_find_contiguous_set
    d = Decoder.new('./test_input', 5)
    assert_equal [15,25,47,40], d.find_contiguous_set(127)
  end
end
