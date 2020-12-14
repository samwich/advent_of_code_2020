class Schedule
  attr_reader :bus_ids, :earliest_departure_time
  attr_accessor :buses_with_x

  def initialize (file_name)
    File.open(file_name) do |f|
      lines = f.readlines
      raise "input file problem" unless lines[2].nil?
      @earliest_departure_time = lines[0].to_i
      @bus_ids = lines[1].split(',').reject { |x| x == 'x' }.map(&:to_i)
      @buses_with_x = lines[1].split(',').map(&:to_i)
    end
  end

  def find_first_bus
    (@earliest_departure_time..).each do |i|
      @bus_ids.each do |bus|
        if i % bus == 0
          # puts "Wait #{i - @earliest_departure_time} minutes for bus #{bus} at time #{i}."
          return {
            bus: bus,
            time: i,
          }
        end
      end
    end
  end

  def find_subsequent
    result = false
    (0..).each do |i|
      time = @buses_with_x.first * i
      @buses_with_x.each_with_index do |bus, i|
        next if bus == 0
        if ((time + i) % bus) == 0
          result = time
        else
          result = false
          break
        end
      end
      
      if i % 10_000 == 0
        puts time
      end

      if result
        return result
      else
        next
      end
    end
  end
end
