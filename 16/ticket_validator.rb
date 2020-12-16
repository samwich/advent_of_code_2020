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
    
    @combined_ranges = run_combine_ranges
    @valid_tickets = validate_tickets
    pp @valid_tickets
  end
  
  def validate_tickets
    @nearby_tickets.select do |t|
      bad_fields_for_ticket(t).flatten.empty?
    end
  end
  
  def bad_fields_for_ticket ticket
    ticket.select do |field|
      result = true
      @combined_ranges.each do |a,b|
        if (a..b).include?(field)
          result = false
          break
        end
      end
  
      result
    end
  end
  
  def ticket_scanning_error_rate
    @nearby_tickets.reduce([]) do |acc, fields|
      acc << bad_fields_for_ticket(fields)
    end.flatten.sum
  end
  
  def run_combine_ranges
    ranges = @rules.reduce([]) do |acc, h|
      acc << h[1][0]
      acc << h[1][1]
    end
    
    combine_ranges(ranges)
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