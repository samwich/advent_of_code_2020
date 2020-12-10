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
        difference = 3 # my device is +3
      else
        difference = adaptors[i+1] - a
      end
      distribution[difference] += 1
      puts "#{a} + #{difference} = #{a + difference}"
    end
    distribution
  end
  
  def to_tree
    make_tree adaptors
  end
  
  def make_tree (input)
    input.append(0) # charging outlet
    adaptors = input.sort
    tree = Hash.new { |h,k| h[k] = [] }
    adaptors.each_with_index do |a,i|
      adaptors[i+1, 3].each do |candidate|
        if candidate <= (a + 3)
          tree[a] << candidate
        end
      end
    end
    tree
  end
  
end
