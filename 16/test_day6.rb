require "test/unit"

require_relative "ticket_validator"

class TestTicketValidator < Test::Unit::TestCase
  def test_read_file
    tv = TicketValidator.new('./test_input')
  end

  def test_combine_ranges
    tv = TicketValidator.new('./test_input')
    tv.run_combine_ranges
  end

  def test_error_rate
    tv = TicketValidator.new('./test_input')
    assert_equal(71, tv.ticket_scanning_error_rate)
  end
  
  def test_cwr
    tv = TicketValidator.new('./test_input2')
    pp tv.columns_with_rules
  end
  
  def test_rule_positions
    tv = TicketValidator.new('./test_input2')
    assert_equal({"row"=>0, "class"=>1, "seat"=>2}, tv.rule_positions)
  end
end