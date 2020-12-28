class ComboBreaker
  SUBJECT_NUMBER = 7
  MOD_NUMBER = 20201227

  def initialize(pub_keys)
    @key1, @key2 = pub_keys
  end

  def transform(loop_size, subject_number=SUBJECT_NUMBER)
    value = 1
    loop_size.times do
      value = transform_op(value, subject_number)
    end
    value
  end

  def transform_op(value, subject)
    (value * subject) % MOD_NUMBER
  end

  def get_loop_size(pub_key)
    value = 1
    loop_size = 1
    while true
      # puts loop_size if loop_size % 10000 == 0

      value = transform_op(value, SUBJECT_NUMBER)
      if pub_key == value
        return loop_size
      end
      loop_size += 1
    end
  end

  def encryption_key
    k1_loop = get_loop_size(@key1)
    puts "k1_loop #{k1_loop}"
    k2_loop = get_loop_size(@key2)
    puts "k2_loop #{k2_loop}"
    pp transform(k2_loop, @key1)
  end  

end
