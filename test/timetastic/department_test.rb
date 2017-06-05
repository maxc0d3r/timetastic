require "./test/test_helper.rb"

class TimetasticDepartmentTest < Minitest::Test
  def test_exists
    assert Timetastic::Department
  end

  def test_it_gives_back_a_single_department
    VCR.use_cassette('one_department') do
      department = Timetastic::Department.find('83865')
      assert_equal Timetastic::Department, department.class
      assert_equal 83865, department.id
      assert_equal "Robocop Technologies ", department.name
      assert_equal 2, department.userCount
      assert_equal 271886, department.bossId
    end
  end

  def test_it_gives_back_all_departments
    VCR.use_cassette('all_departments') do
      result = Timetastic::Department.all
      assert result.kind_of?(Array)
    end
  end
end
