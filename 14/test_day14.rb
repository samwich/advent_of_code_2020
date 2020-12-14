require "test/unit"

require_relative "machine"

class TestMachine < Test::Unit::TestCase
  def test_case_name
    m = Machine.new('./test_input')
    # pp m.instructions
    m.run
    assert_equal(165, m.memory_sum)
  end
end