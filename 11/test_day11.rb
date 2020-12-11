require "test/unit"

require_relative "seating"

class TestSeating < Test::Unit::TestCase
  def test_read_file
    s = Seating.new('./test0')
    assert_equal(10, s.before.length)
    assert_equal(10, s.before.first.length)
  end
  
  def test_iterations
    s = Seating.new('./test0')
    after1 = s.read_file('./test1')
    after2 = s.read_file('./test2')
    s.process_board
    assert_equal(after1, s.before)
    s.process_board
    assert_equal(after2, s.before)
  end
end