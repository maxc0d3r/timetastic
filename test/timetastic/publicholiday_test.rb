require "./test/test_helper.rb"

class TimetasticPublicHolidayTest < Minitest::Test
  def test_exists
    assert Timetastic::PublicHoliday
  end

  def test_it_gives_back_a_single_publicholiday
    VCR.use_cassette('one_publicholiday') do
      holiday = Timetastic::PublicHoliday.find('10318423')
      assert_equal Timetastic::PublicHoliday, holiday.class
      assert_equal 10318423, holiday.id
      assert_equal "Independence Day", holiday.name
      assert_equal "2017-08-15T00:00:00", holiday.date
      assert_equal "ZZ", holiday.countryCode
    end
  end

  def test_it_gives_back_all_publicholidays
    VCR.use_cassette('all_publicholidays') do
      result = Timetastic::PublicHoliday.all
      assert result.kind_of?(Array)
    end
  end
end
