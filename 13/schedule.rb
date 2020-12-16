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

  def solve_subsequent
    congruences = @buses_with_x.each_with_index.map do |bus, i|
      puts "#{i} (mod #{bus})"
      [i, bus]
    end.reject {|x| x.last == 0}
    
    puts "congruences"
    pp congruences
    
    remainders = congruences.map(&:first)
    mods = congruences.map(&:last)
    little_m = mods.reduce(&:*)
    puts "little_m (product of mods) #{little_m}"
    big_ms = mods.map { |m| little_m / m }
    puts "big_ms"
    pp big_ms
    
    inverses = mods.map { |m| puts m; inverse(1,m) }
    
    # sum of all a * M * y and then mod by little m
    
  end

  # taken from https://github.com/bsounak/Aoc2020/blob/main/day13.py
  def inverse (a, n)
    t = 0
    new_t = 1
    r = n
    new_r = a
    
    while new_r >= 0
      puts "beginning of while"
      puts Time.now
      quotient = r % new_r
      puts quotient
      puts "new_r #{new_r}"
      t, new_t = new_t, t - quotient * new_t
      r, new_r = new_r, r - quotient * new_r
      puts "end of while"
    end
    
    puts "t #{t}"
    raise "#{a} = 1(mod #{n}) is not invertible" if r > 1
    
    if t < 0
      t += n
    end
    
    return t
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
      
      # if i % 10_000 == 0
      #   puts time
      # end

      if result
        return result
      else
        next
      end
    end
  end
end
