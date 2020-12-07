class RuleSet
  attr_reader :raw_rules
  
  def initialize (file_name)
    @raw_rules = File.readlines(file_name, chomp:true)
  end
end
