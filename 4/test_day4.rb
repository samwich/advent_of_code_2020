require 'test/unit'
require_relative 'batch_file'
require_relative 'batch_record'
require_relative 'passport'

class TestDay4 < Test::Unit::TestCase

  def test_open_file
    assert_nothing_raised(Exception) { BatchFile.new('./test_input') }
    
  end
  
  def test_enumeration
    assert_equal(Enumerator, [1,2,3].each.class)
  end
  
  def test_split_into_records
    assert_equal(4, BatchFile.new('./test_input').raw_records.length)
  end
  
  def test_batch_record
    raw_record = BatchFile.new('./test_input').raw_records.first
    br = BatchRecord.new(raw_record)
    pp br.fields
    assert_equal(8, br.fields.length)
  end
  
  def test_passport
    passports = BatchFile.new('./test_input').passports
    assert_equal 2, passports.map { |e| e.valid? }.count { |e| e }
  end
end
