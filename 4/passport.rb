class Passport
  
  REQUIRED_FIELDS = [
    'ecl',
    'pid',
    'eyr',
    'hcl',
    'byr',
    'iyr',
    'cid',
    'hgt',
  ]

  
  def initialize (fields)
    @fields = fields
  end
  
  def valid?
    REQUIRED_FIELDS.each do |rf|
      next if rf == 'cid' # special enhanced scrutiny
      unless @fields[rf]
        return false
      end
    end
    true
  end
end
