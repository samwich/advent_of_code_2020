class GroundStation
  def initialize (file_name)
    @rules = []
    File.open(file_name) do |f|
      while true
        l = f.readline
        break if l.strip.empty?
        idx, rules = parse_rule(l)
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
    
    # pp @rules
    pp @messages
  end
  
  def parse_rule (line)
    # puts line
    matches = /^(?<addr>\d+): ("(?<char>[ab])"$|(?<list1>\d( \d)*))( \| (?<list2>\d( \d)*))?/.match(line)
    # pp matches
    
    addr = matches[:addr].to_i
    
    references = [matches[:list1], matches[:list2]].compact.map do |list|
      list.split(' ').map(&:to_i)
    end
    
    if matches[:char]
      rules = [matches[:char]]
    else
      rules = references
    end
    
    [ addr, rules ]
  end
end