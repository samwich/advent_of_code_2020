class Schedule
  attr_reader :bus_ids, :earliest_departure_time
  def initialize (file_name)
    File.open(file_name) do |f|
      lines = f.readlines
      raise "input file problem" unless lines[2].nil?
      @earliest_departure_time = lines[0].to_i
      @bus_ids = lines[1].split(',').reject { |x| x == 'x' }.map(&:to_i)
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

end
