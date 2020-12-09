require 'test/unit'
require_relative 'decoder'

class TestDay9 < Test::Unit::TestCase

  def test_find_sum
    d = Decoder.new('./test_input')
    entries = d.entries[0,5]
    sum = d.entries[5]
    assert_equal([25, 15], d.day1_2sum_with_map(entries, sum) )
  end
  
  
  
end
