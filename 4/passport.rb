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
      unless @fields[rf]
        return false
      end
    end
    true
  end
end
