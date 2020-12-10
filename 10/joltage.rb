class Joltage
  attr_reader :path_execution_count
  
  def initialize (file_name)
    File.open(file_name) do |f|
      @input = f.each_line.map(&:to_i)
    end
    @input.append(0) # charging outlet
    @tree = make_tree(@input)
  end
  
  def process_file
    process(@input)
  end
  
  def process (input)
    adaptors = input.sort
    distribution = Hash.new { |h,k| h[k] = 0 }
    adaptors.each_with_index do |a, i|
      if adaptors[i+1].nil?
        difference = 3 # my device is +3
      else
        difference = adaptors[i+1] - a
      end
      distribution[difference] += 1
      # puts "#{a} + #{difference} = #{a + difference}"
    end
    distribution
  end
  
  def make_tree (input)
    adaptors = input.sort
    adaptors << adaptors.last + 3 # my device is +3
    tree = Hash.new { |h,k| h[k] = { children: [] } }
    adaptors.each_with_index do |a,i|
      adaptors[i+1, 3].each do |candidate|
        if candidate <= (a + 3)
          tree[a][:children] << candidate
        end
      end
    end
    tree[adaptors.last][:children] = []
    tree
  end
  
  def path_count (node=0)
    # early return
    if @tree[node][:path_count]
      return @tree[node][:path_count]
    end
    @path_execution_count ||= 0
    @path_execution_count += 1
    children = @tree[node][:children]
    count = 0
    if children.length == 0
      count += 1
    end
    count += children.reduce(0) do |sum, c|
      sum + path_count(c)
    end
    @tree[node][:path_count] = count
  end
  
end
