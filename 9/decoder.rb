class Decoder
  attr_reader :entries
  
  def initialize (file_name, window_size)
    @entries = File.open(file_name) { |f| f.each_line.map(&:to_i) }
    @window_size = window_size
  end
  
  def find_problem
    (@window_size..(@entries.length - 1)).each_with_index do |e, i|
      first_index = i
      last_index = i + @window_size
      sum_index = last_index + 1
      puts "Checking #{i} of #{@entries.length}"
      next if find_two_sum(first_index, last_index, sum_index)
      return @entries[sum_index]
    end
  end
  
  def find_contiguous_set (number)
    (0..@entries.length).each do |first_index|
      sum = @entries[first_index]
      cursor = first_index + 1
      while sum < number
        sum += @entries[cursor]
        if sum == number
          return @entries[first_index..cursor]
        end
        cursor += 1
      end
    end
  end
  
  def find_two_sum (first_index, last_index, sum_index)
    candidates = {}
    i = first_index
    sum = @entries[sum_index]
    while i <= last_index
      a = @entries[i]
      b = sum - a
      if candidates[b]
        return [a, b]
      end
      candidates[a] = true
      i += 1
    end
  end
  
  
  def day1_2sum_with_map (entries, sum)
    candidates = {}
    entries.each do |a|
      b = sum - a
      if candidates[b]
        return [a, b]
      end
      candidates[a] = true
    end
  end  
  
end



