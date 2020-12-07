class RuleSet
  attr_reader :raw_rules, :bags
  
  def initialize (file_name)
    @raw_rules = File.readlines(file_name, chomp:true)
    @reverse_index = Hash.new {|h,k| h[k] = {}}
    @bags = process_bags
  end
  
  def process_bags
    @raw_rules.map do |rr|
      b = Bag.new(rr)
      b.child_rules.each do |n, c|
        @reverse_index[n][b.name] = b
      end
      b
    end.reduce({}) do |bags, b|
      bags.merge({ b.name => b })
    end
  end
  
  def bags_that_can_contain (bag_name, visited={}, count=nil)
    @reverse_index[bag_name].each_key do |k|
      next if visited[k]
      visited[k] = true
      bags_that_can_contain(k, visited)
    end
    visited
  end
  
  def bags_contained_in (bag_name)
    @bags[bag_name].child_rules.reduce(0) do |sum, rules|
      name = rules[0]
      count = rules[1]
      child_bag_count = (count * (1 + bags_contained_in(name)))
      sum + child_bag_count
    end
  end
end
