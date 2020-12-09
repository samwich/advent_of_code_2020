class Decoder
  attr_reader :entries
  
  def initialize (file_name)
    @entries = File.open(file_name) { |f| f.each_line.map(&:to_i) }
    
  end
  
  def day1_2sum_with_map (entries, sum)
    candidates = {}
    entries.each_with_index do |a, i|
      complement = sum - a
      if candidates[complement]
        return [a, complement]
      end
      candidates[a] = true
    end
  end
  
  
    
end
