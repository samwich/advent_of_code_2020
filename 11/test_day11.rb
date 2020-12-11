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
    after3 = s.read_file('./test3')
    after4 = s.read_file('./test4')
    after5 = s.read_file('./test5')
    s.process_board
    assert_equal(after1, s.before)
    s.process_board
    assert_equal(after2, s.before)
    s.process_board
    assert_equal(after3, s.before)
    s.process_board
    assert_equal(after4, s.before)
    s.process_board
    assert_equal(after5, s.before)
    # shouldn't change after that iteration
    s.process_board
    assert_equal(after5, s.before)
  end
  
  def test_run_to_stable_and_count_occupied
    s = Seating.new('./test0')
    s.run_to_stable
    assert_equal(37, s.count_occupied)
  end
end
