class TicketValidator
  RULE_REGEXP = /^([a-z ]+): (\d+)-(\d+) or (\d+)-(\d+)$/
  
  def initialize (file_name)
    File.open(file_name) do |f|
      @rules = {}
      while true
        l = f.readline
        break if l.strip.empty?
        matches = RULE_REGEXP.match(l)
        @rules[matches[1]] = [
          [matches[2].to_i,matches[3].to_i],
          [matches[4].to_i,matches[5].to_i]
        ]
      end
      
      while true
        l = f.readline
        next if l.strip == 'your ticket:'
        break if l.strip.empty?
        @your_ticket = l.split(',').map(&:to_i)
      end
      
      @nearby_tickets = []
      while true
        begin
          l = f.readline
          next if l.strip == 'nearby tickets:'
          @nearby_tickets << l.split(',').map(&:to_i)
        rescue EOFError
          break
        end
      end
      
    end
    pp @rules
    # pp @your_ticket
    # pp @nearby_tickets
  end
  
  def run_combine_ranges
    ranges = @rules.reduce([]) do |acc, h|
      acc << h[1][0]
      acc << h[1][1]
    end
    
    pp combine_ranges(ranges)
    puts "END run_combine_ranges"
  end
  
  def combine_ranges (ranges)
    ranges.sort.reduce([]) do |combined,r|
      if combined.empty?
        combined << r
      elsif overlap?(combined[-1], r)
        combined[-1] = combine(combined[-1], r)
        combined
      else
        combined << r
      end
    end
  end
  
  def overlap? (a, b)
    a1, a2 = a
    b1, b2 = b
    (a1..a2).include?(b1) ||  
    (a1..a2).include?(b2) ||  
    (b1..b2).include?(a1) || 
    (b1..b2).include?(a2)
  end
  
  def combine (a, b)
    a1, a2 = a
    b1, b2 = b
    result = [ [a1, b1].min, [a2, b2].max ]
  end
  
end