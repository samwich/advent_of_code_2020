require 'test/unit'
require_relative 'bag'
require_relative 'rule_set'

class TestDay7 < Test::Unit::TestCase
  def test_rule_set
    rs = RuleSet.new('./test_input')
    assert_equal 9, rs.raw_rules.length
    assert_equal Hash, rs.bags.class
    assert_equal 9, rs.bags.length
  end
  
  def test_bag_with_2_rules
    rs = RuleSet.new('./test_input')
    bag = Bag.new(rs.raw_rules[0])
    assert_equal({'light red' => {'bright white' => 1, 'muted yellow' => 2}}, bag.rule)
  end
  def test_bag_with_1_rule
    rs = RuleSet.new('./test_input')
    bag = Bag.new(rs.raw_rules[2])
    assert_equal({'bright white' => {'shiny gold' => 1}}, bag.rule)
  end
  def test_bag_with_no_rules
    rs = RuleSet.new('./test_input')
    bag = Bag.new(rs.raw_rules[7])
    assert_equal({'faded blue' => {}}, bag.rule)
  end
  
  def test_find_reachable_bags
    rs = RuleSet.new('./test_input')
    assert_equal 4, rs.bags_that_can_contain('shiny gold').length
  end
  
  def test_sum_of_bags_contained
    rs1 = RuleSet.new('./test_input')
    rs2 = RuleSet.new('./test_input2')
    assert_equal 32, rs1.bags_contained_in('shiny gold')
    assert_equal 126, rs2.bags_contained_in('shiny gold')
  end
end
