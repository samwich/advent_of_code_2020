require 'test/unit'
require_relative 'batch_file'

class TestDay6 < Test::Unit::TestCase

  def test_read_input
    rr = BatchFile.new('./test_input').raw_records
    pp rr
    assert_equal 5, rr.length
  end

  def test_count_group_answers
    bf = BatchFile.new('./test_input')
    pp bf.sum_of_yes_counts
    assert_equal 11, bf.sum_of_yes_counts
  end

end
