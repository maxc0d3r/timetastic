module Timetastic
  class User
    attr_accessor :id, :firstname, :surname, :email, :admin, :organizationId, :departmentId, :allowanceUnit, :bossOfDepartments, :endDate, :departmentName, :gravatar, :allowanceRemaining, :hasLoggedOn, :isArchived, :approverId, :deptBossId, :birthday, :startDate, :currentYearAllowance, :nextYearAllowance

    def initialize(attributes)
      @id = attributes["id"]
      @firstname = attributes["firstname"]
      @surname = attributes["surname"]
      @email = attributes["email"]
      @admin = attributes["admin"]
      @organizationId = attributes["organizationId"]
      @departmentId = attributes["departmentId"]
      @allowanceUnit = attributes["allowanceUnit"]
      @bossOfDepartments = attributes["bossOfDepartments"]
      @endDate = attributes["endDate"]
      @departmentName = attributes["departmentName"]
      @gravatar = attributes["gravatar"]
      @allowanceRemaining = attributes["allowanceRemaining"]
      @hasLoggedOn = attributes["hasLoggedOn"]
      @isArchived = attributes["isArchived"]
      @approverId = attributes["approverId"]
      @deptBossId = attributes["deptBossId"]
      @birthday = attributes["birthday"]
      @startDate = attributes["startDate"]
      @currentYearAllowance = attributes["currentYearAllowance"]
      @nextYearAllowance = attributes["nextYearAllowance"]
    end

    def self.all(options={},filters={})
      conn = Faraday.new
      conn.authorization :Bearer, ENV["TIMETASTIC_API_TOKEN"]
      response = conn.get("#{API_URL}/users",options)
      users = JSON.parse(response.body)
      unless filters == nil
        filters.each do |k,v|
          users = users.select { |user| user[k] == v }
        end
      end
      users.map { |attributes| new(attributes) }
    end

    def self.find(id)
      conn = Faraday.new
      conn.authorization :Bearer, ENV["TIMETASTIC_API_TOKEN"]
      response = conn.get("#{API_URL}/users/#{id}")
      attributes = JSON.parse(response.body)
      new attributes
    end
  end
end
