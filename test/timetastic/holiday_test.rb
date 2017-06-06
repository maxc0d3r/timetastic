require "./test/test_helper.rb"

class TimetasticHolidayTest < Minitest::Test
  def test_exists
    assert Timetastic::Holiday
  end

  def test_it_gives_back_a_single_holiday
    VCR.use_cassette('one_holiday') do
      holiday = Timetastic::Holiday.find('2557253')
      assert_equal Timetastic::Holiday, holiday.class
      assert_equal 2557253, holiday.id
      assert_equal "Morning", holiday.startType
      assert_equal "2017-06-09T00:00:00", holiday.startDate
      assert_equal "Afternoon", holiday.endType
      assert_equal "2017-06-09T00:00:00", holiday.endDate
      assert_equal "Mayank Joshi", holiday.userName
      assert_equal "Out sick", holiday.reason
    end
  end

  def test_it_gives_back_all_holidays
    VCR.use_cassette('all_holidays') do
      result = Timetastic::Holiday.all
      assert result.kind_of?(Array)
    end
  end

  def test_it_books_a_holiday
    VCR.use_cassette('book_holiday') do
      result = Timetastic::Holiday.book('2017-07-20','2017-07-21','AM','PM','Sick','Holiday','mail2mayank@gmail.com')
      assert_equal true, result["success"]
    end
  end
end
