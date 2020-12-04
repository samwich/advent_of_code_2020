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

  VALIDATORS = {
    'byr' => ->(x) { (1920..2002).include?(x.to_i) }, # byr (Birth Year) - four digits; at least 1920 and at most 2002.
    'iyr' => ->(x) { (2010..2020).include?(x.to_i) }, # iyr (Issue Year) - four digits; at least 2010 and at most 2020.
    'eyr' => ->(x) { (2020..2030).include?(x.to_i) }, # eyr (Expiration Year) - four digits; at least 2020 and at most 2030.
    'hgt' => ->(x) do              # hgt (Height) - a number followed by either cm or in:
      if x[-2,2] == 'cm'
        (150..193).include?(x.to_i)  # If cm, the number must be at least 150 and at most 193.
      elsif x[-2,2] == 'in'
        (59..76).include?(x.to_i)    # If in, the number must be at least 59 and at most 76.
      else
        false
      end
    end, 
    'hcl' => ->(x) { /^#[0-9a-f]{6}$/.match?(x) }, # hcl (Hair Color) - a # followed by exactly six characters 0-9 or a-f.
    'ecl' => ->(x) { /^(amb|blu|brn|gry|grn|hzl|oth)$/.match? x }, # ecl (Eye Color) - exactly one of: amb blu brn gry grn hzl oth.
    'pid' => ->(x) { /\d{9}/.match?(x) }, # pid (Passport ID) - a nine-digit number, including leading zeroes.
    'cid' => ->(x) { true }, # cid (Country ID) - ignored, missing or not.
  }

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
    
    VALIDATORS.each do |name, validator|
      unless validator.call @fields[name]
        puts "fail: #{name} #{@fields[name]}"
        return false
      end
    end
    
    true
  end
end
