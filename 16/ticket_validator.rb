class TicketValidator
  RULE_REGEXP = /^([a-z ]+): (\d+)-(\d+) or (\d+)-(\d+)$/
  
  def initialize (file_name)
    File.open(file_name) do |f|
      @rules = {}
      while true
        l = f.readline
        break if l.strip.empty?
        matches = RULE_REGEXP.match(l)
        @rules[matches[1]] = [[matches[2],matches[3]],[matches[4],matches[5]]]
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
    pp @your_ticket
    pp @nearby_tickets
  end
end