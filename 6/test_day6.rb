require 'test/unit'
require_relative 'batch_file'

class TestDay6 < Test::Unit::TestCase

  def test_case_name
    rr = BatchFile.new('./test_input').raw_records
    pp rr
    assert_equal 5, rr.length
  end

end
