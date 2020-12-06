require 'test/unit'
require_relative 'batch_file'
require 'set'

class TestDay6 < Test::Unit::TestCase

  def test_read_input
    rr = BatchFile.new('./test_input').raw_records
    assert_equal 5, rr.length
  end

  def test_count_group_answers
    bf = BatchFile.new('./test_input')
    assert_equal 11, bf.sum_of_yes_counts
  end

  def test_answer_intersections
    bf = BatchFile.new('./test_input')
    assert_equal 6, bf.sum_of_intersections
  end

end
