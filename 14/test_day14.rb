require "test/unit"

require_relative "machine"
require_relative "machine2"

class TestMachine < Test::Unit::TestCase
  def test_case_name
    m = Machine.new('./test_input')
    # pp m.instructions
    m.run
    assert_equal(165, m.memory_sum)
  end
  
  def test_machine2
    m = Machine2.new('./test_input2')
    m.run
    assert_equal(208, m.memory_sum)
  end
end