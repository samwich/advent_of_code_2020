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
end