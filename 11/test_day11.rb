require "test/unit"

require_relative "seating"

class TestSeating < Test::Unit::TestCase
  def test_read_file
    s = Seating.new('./test0')
    assert_equal(10, s.before.length)
    assert_equal(10, s.before.first.length)
  end
end