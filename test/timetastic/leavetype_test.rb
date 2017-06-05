require "./test/test_helper.rb"

class TimetasticLeaveTest < Minitest::Test
  def test_exists
    assert Timetastic::LeaveType
  end

  def test_it_gives_back_a_single_leavetype
    VCR.use_cassette('one_leavetype') do
      leavetype = Timetastic::LeaveType.find('121711')
      assert_equal Timetastic::LeaveType, leavetype.class
      assert_equal 121711, leavetype.id
      assert_equal "Holiday", leavetype.name
      assert_equal true, leavetype.deducted
      assert_equal true, leavetype.requiresApproval
    end
  end

  def test_it_gives_back_all_leavetypes
    VCR.use_cassette('all_leavetypes') do
      result = Timetastic::LeaveType.all
      assert result.kind_of?(Array)
    end
  end
end
