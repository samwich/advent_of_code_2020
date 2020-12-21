class GroundStation
  def initialize (file_name, overrides=[])
    @rules = []
    File.open(file_name) do |f|
      while true
        l = f.readline
        break if l.strip.empty?
        idx, rules = read_rule(l)
        @rules[idx] = rules
      end
      
      @messages = []
      while true
        begin
          l = f.readline
          @messages << l.chomp
        rescue EOFError
          break
        end
      end
    end

    @overrides = overrides

    pp @rules
    # pp @messages

    @rules_cache = []
    @regexp1 = /^#{build_rule(0)}$/
    pp @regexp1
  end
  
  def read_rule (line)
    # puts line
    matches = /^(?<addr>\d+): ("(?<char>[ab])"$|(?<list1>\d+( \d+)*))( \| (?<list2>\d+( \d+)*))?/.match(line)
    # pp matches
    
    addr = matches[:addr].to_i
    
    references = [matches[:list1], matches[:list2]].compact.map do |list|
      list.split(' ').map(&:to_i)
    end
    
    if matches[:char]
      rules = [[matches[:char]]]
    else
      rules = references
    end

    [ addr, rules ]
  end
  
  def pass? (addr, message)
    
  end
  
  #  8: (42)+
  # 11: (?<nest>42(\g<nest>)?31)

  def build_rule (i)
    return i if i.instance_of? String
    @rules_cache[i] ||= begin
      puts "build_rule(#{i})"

      if @overrides.include? i
        if i == 8
          puts "rule 8"
          return "(#{build_rule(42)})+"
        elsif i == 11
          puts "rule 11"
          return "(?<nest>#{build_rule(42)}(\\g<nest>)?#{build_rule(31)})"
        end
      end

      rule = @rules[i]

      x = rule.map do |r|
        r.map do |rr|
          build_rule rr
        end.join
      end.join('|')
      if x.include?('|')
        "(#{x})"
      else
        x
      end
    end
  end
  
  def check_messages
    @messages.map do |m|
      result = @regexp1.match?(m)
      puts "#{m}: #{result}"
      result
    end
  end
end
