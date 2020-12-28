require 'test/unit'
require_relative 'combo_breaker'

class TestComboBreaker < Test::Unit::TestCase
  def setup
    @card_pub = 5764801
    @door_pub = 17807724
    @cb = ComboBreaker.new([@card_pub, @door_pub])
  end

  def test_get_loop_size_card
    assert_equal(8, @cb.get_loop_size(@card_pub))
  end

  def test_get_loop_size_door
    assert_equal(11, @cb.get_loop_size(@door_pub))
  end
end
