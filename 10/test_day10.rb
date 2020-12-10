require "test/unit"

require_relative "joltage"

class TestJoltage < Test::Unit::TestCase
  def test_one
    input = [16, 10, 15, 5, 1, 11, 7, 19, 6, 12, 4] << 0 # add the outlet
    j = Joltage.new('./test_input')
    assert_equal({1=>7,3=>5}, j.process(input))
  end
  
  def test_from_file
    j = Joltage.new('./test_input')
    assert_equal({1=>22,3=>10}, j.process_file)
  end
  
  def test_make_tree
    input = [16, 10, 15, 5, 1, 11, 7, 19, 6, 12, 4] << 0 # add the outlet
    output = {
      0 =>{children: [1]},
      1 =>{children: [4]},
      4 =>{children: [5, 6, 7]},
      5 =>{children: [6, 7]},
      6 =>{children: [7]},
      7 =>{children: [10]},
      10=>{children: [11, 12]},
      11=>{children: [12]},
      12=>{children: [15]},
      15=>{children: [16]},
      16=>{children: [19]},
      19=>{children: [22]},
      22=>{children: []},
    }
    j = Joltage.new('./test_input')
    assert_equal(output, j.make_tree(input))
  end
  
  def test_path_count
    j = Joltage.new('./test_input')
    assert_equal(19208, j.path_count)
    pp j.path_execution_count
  end
  
end
