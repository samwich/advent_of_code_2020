require 'test/unit'
require_relative 'game_kid'

class TestDay8 < Test::Unit::TestCase
  def test_parse
    expected = [
      ['nop', +0],
      ['acc', +1],
      ['jmp', +4],
      ['acc', +3],
      ['jmp', -3],
      ['acc', -99],
      ['acc', +1],
      ['jmp', -4],
      ['acc', +6],
    ]
    
    gamekid = GameKid.new('./test_input')
    
    assert_equal expected, gamekid.instructions
  end
  
  def test_run
    gamekid = GameKid.new('./test_input')
    assert_equal 5, gamekid.run
  end
  
end