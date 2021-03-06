class Bag
  attr_reader :name, :child_rules

  def initialize (raw_rule)
    @name, @child_rules = parse_name_and_rules(raw_rule)
  end

  # dark orange bags contain 3 bright white bags, 4 muted yellow bags.
  # bright white bags contain 1 shiny gold bag.
  # faded blue bags contain no other bags.

  def rule
    { name => child_rules }
  end

  def parse_name_and_rules (raw_rule)
    match = /^(?<name>[a-z ]+) bags contain (?<child_rules>[a-z0-9, ]+)\.$/.match(raw_rule)
    [ match['name'], parse_child_rules(match['child_rules']) ]
  end
  
  def parse_child_rules (raw_child_rules)
    cr = {}
    raw_child_rules.split(',').map(&:strip).each do |rcr|
      match = /(?<empty>no other)|(?<number>\d+) (?<name>[a-z ]+) bag/.match(rcr)
      unless match['empty']
        cr[match['name']] = match['number'].to_i
      end
    end
    cr
  end
  
end
