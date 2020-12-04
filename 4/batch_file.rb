class BatchFile
  def initialize (file_name)
    @file_name = file_name
  end
  
  def raw_records
    raw_records = []
    this_record = ''

    File.open(@file_name) do |f|

      f.each_line do |line|
        if line == "\n"
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
  
  def batch_records
    raw_records.map { |rr| BatchRecord.new rr }
  end
  
  def passports
    batch_records.map { |br| Passport.new br.fields }
  end
end
