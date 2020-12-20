class GroundStation
  def initialize (file_name)
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

    pp @rules
    # pp @messages

    @rules_cache = []
    @regexp1 = /^#{build_rule(0)}$/
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
  
  def build_rule (i)
    return i if i.instance_of? String
    @rules_cache[i] ||= begin
      puts "build_rule(#{i})"

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
    @messages.each do |m|
      puts "#{m}: #{@regexp1.match? m}"
    end
  end
end
