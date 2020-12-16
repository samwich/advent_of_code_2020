require "test/unit"

require_relative "ticket_validator"

class TestTicketValidator < Test::Unit::TestCase
  # def test_read_file
  #   tv = TicketValidator.new('./test_input')
  # end

  def test_combine_ranges
    tv = TicketValidator.new('./test_input')
    tv.run_combine_ranges
  end
end