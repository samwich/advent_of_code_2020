class ComboBreaker
  SUBJECT_NUMBER = 7
  MOD_NUMBER = 20201227

  def initialize(pub_keys)
    @key1, @key2 = pub_keys
  end

  def transform(loop_size, subject_number=SUBJECT_NUMBER)
    value = 1
    loop_size.times do
      value = value * subject_number
      value = value % MOD_NUMBER
    end
    value
  end

  def get_loop_size(pub_key)
    loop_size = 1
    while true
      if pub_key == transform(loop_size)
        return loop_size
      end
      loop_size += 1
    end
  end

  def encryption_key
    k1_loop = get_loop_size(@key1)
    k2_loop = get_loop_size(@key2)
    transform(k2_loop, @key1)
  end  

end
