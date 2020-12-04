class BatchRecord
  attr_reader :fields
  
  def initialize (raw_record)
    @raw_record = raw_record
    @fields = {}
    raw_record.split.each do |r|
      k, v = r.split(':')
      @fields[k] = v
    end
  end
end
