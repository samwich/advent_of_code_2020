class BatchFile
  def initialize (file_name)
    @file_name = file_name
  end
  
  def raw_records
    raw_records = []
    this_record = ''

    File.open(@file_name) do |f|

      f.each_line(chomp: true) do |line|
        if line.empty?
          raw_records << this_record
          this_record = ''
        else
          this_record << line
        end
      end

    end
    raw_records << this_record
    raw_records
  end
  
  def sum_of_yes_counts
    raw_records.map { |x| x.chars.uniq.length }.sum
  end
end
