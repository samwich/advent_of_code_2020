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
    
    # all_buses_with_depart_times = @buses_with_x.each_with_index.map { |b, i| [b, b.zero? ? 0 : -i % b] }.reject { |p| p.first.zero? }
    #
    # puts "@buses_with_x and all_buses_with_depart_times"
    # pp @buses_with_x
    # pp all_buses_with_depart_times
    
    
    # (-i % bus) for the remainder is from
    # https://www.reddit.com/r/adventofcode/comments/kc4njx/2020_day_13_solutions/gfrw3ms/
    congruences = @buses_with_x.each_with_index.map do |bus, i|
      # puts "#{i} (mod #{bus})"
      r = bus.zero? ? 0 : -i % bus
      [r, bus]
    end.reject {|x| x.last == 0}
    
    puts "congruences"
    pp congruences
    
    remainders = congruences.map(&:first)
    mods = congruences.map(&:last)
    # little_m = mods.reduce(&:*)
    # puts "little_m (product of mods) #{little_m}"
    # big_ms = mods.map { |m| little_m / m }
    # puts "big_ms"
    # pp big_ms
    #
    # inverses = mods.map { |m| puts m; inverse(1,m) }
    
    # sum of all a * M * y and then mod by little m

    # pp mods
    # pp remainders
    #
    # p chinese_remainder([3,5,7], [2,3,2])     #=> 23
    # p chinese_remainder([17353461355013928499, 3882485124428619605195281, 13563122655762143587], [7631415079307304117, 1248561880341424820456626, 2756437267211517231]) #=> 937307771161836294247413550632295202816
    # # p chinese_remainder([10,4,9], [11,22,19]) #=> nil
    # p chinese_remainder([1789, 37, 47, 1889], [0, 1, 2, 3]) # 1202161486 ?


    # https://rosettacode.org/wiki/Chinese_remainder_theorem#Ruby
    chinese_remainder(mods, remainders)
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
  
  # https://rosettacode.org/wiki/Chinese_remainder_theorem#Ruby
  def extended_gcd(a, b)
    last_remainder, remainder = a.abs, b.abs
    x, last_x, y, last_y = 0, 1, 1, 0
    while remainder != 0
      last_remainder, (quotient, remainder) = remainder, last_remainder.divmod(remainder)
      x, last_x = last_x - quotient*x, x
      y, last_y = last_y - quotient*y, y
    end
    return last_remainder, last_x * (a < 0 ? -1 : 1)
  end
 
  # https://rosettacode.org/wiki/Chinese_remainder_theorem#Ruby
  def invmod(e, et)
    g, x = extended_gcd(e, et)
    if g != 1
      raise 'Multiplicative inverse modulo does not exist!'
    end
    x % et
  end
 
  # https://rosettacode.org/wiki/Chinese_remainder_theorem#Ruby
  def chinese_remainder(mods, remainders)
    max = mods.inject( :* )  # product of all moduli
    series = remainders.zip(mods).map{ |r,m| (r * max * invmod(max/m, m) / m) }
    series.inject( :+ ) % max 
  end
  
end
