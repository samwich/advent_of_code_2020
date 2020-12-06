class BatchFile
  def initialize (file_name)
    @file_name = file_name
  end
  
  def raw_records
    raw_records = []
    this_record = []

    File.open(@file_name) do |f|

      f.each_line(chomp: true) do |line|
        if line.empty?
          raw_records << this_record
          this_record = []
        else
          this_record << line
        end
      end

    end
    raw_records << this_record
    raw_records
  end
  
  # part 1
  def sum_of_yes_counts
    # a raw record: ["ab", "a"].join.chars.uniq.length == 2
    raw_records.map { |x| x.join.chars.uniq.length }.sum
  end
  
  # part 2
  def sum_of_intersections
    raw_records.map do |group|
      group.map do |record|
        Set.new record.chars
      end.reduce do |intersection, set|
        intersection & set
      end.length # size of set of intersecting answers for this group
    end.sum
  end
  
end
