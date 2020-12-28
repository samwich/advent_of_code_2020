class ComboBreaker
  SUBJECT_NUMBER = 7
  MOD_NUMBER = 20201227

  def initialize(pub_keys)

  end

  def transform(loop_size)
    value = 1
    loop_size.times do
      value = value * SUBJECT_NUMBER
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

  

end
