class TicketValidator
  RULE_REGEXP = /^([a-z ]+): (\d+)-(\d+) or (\d+)-(\d+)$/
  DEPARTURE_REGEX = /^departure/
  
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
    # pp @valid_tickets
  end
  
  def departure_fields_product
    rule_positions.select do |name,index|
      DEPARTURE_REGEX.match? name
    end.map do |k,v|
      @your_ticket[v]
    end.reduce(&:*)
  end
  
  def rule_positions
    cwr = columns_with_rules
    
    while true
      @valid_tickets.first.each_index do |i|
        if cwr[i].keys.length == 1
          rule_name = cwr[i].keys.first
          cwr.each do |k,v|
            next if k == i
            cwr[k].delete(rule_name)
          end
        end
      end
      break if cwr.values.map(&:keys).flatten.length == @valid_tickets.first.length
    end

    # puts "cwr"
    # pp cwr

    rp = {}
    cwr.each do |k,v|
      rp[ v.keys.first ] = k
    end
    # puts "rp"
    # pp rp
    rp
  end
  
  def columns_with_rules
    cwr = {}
    @valid_tickets.first.each_index do |i|
      # puts ''
      # puts "Working on Column index #{i}"
      cwr[i] = valid_rules_for_index(i)
    end
    cwr
  end
  
  def valid_rules_for_index (i)
    rules = @rules.select do |name, ranges|
      # puts "trying #{name} #{ranges}"
      rule_valid = true

      @valid_tickets.each do |t|
        # puts "Ticket #{t}"
        rule_valid = false

        ranges.each do |a,b|
          if (a..b).include?(t[i])
            rule_valid = true
            break
          end
        end
        
        break unless rule_valid == true
      end

      rule_valid
    end

    # pp rules
    rules
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