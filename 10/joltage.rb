class Joltage
  def initialize (file_name)
    File.open(file_name) do |f|
      @input = f.each_line.map(&:to_i)
    end
  end
  
  def process_file
    process(@input)
  end
  
  def process (input)
    input.append(0) # charging outlet
    adaptors = input.sort
    distribution = Hash.new { |h,k| h[k] = 0 }
    adaptors.each_with_index do |a, i|
      if adaptors[i+1].nil?
        distribution[3] += 1 # my device is +3
      else
        difference = adaptors[i+1] - a
        distribution[difference] += 1
      end
      # puts "#{a} +#{difference}"
    end
    distribution
  end
end