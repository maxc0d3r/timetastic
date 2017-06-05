module Timetastic
  class Department
    attr_accessor :id, :name, :bossId, :givePublicHolidays, :archived, :organizationId, :countryCode, :userCount, :currentAllowance, :nextAllowance, :maxOff, :bankHolidaySetId

    def initialize(attributes)
      @id = attributes["id"]
      @name = attributes["name"]
      @bossId = attributes["bossId"]
      @givePublicHolidays = attributes["givePublicHolidays"]
      @archived = attributes["archived"]
      @organizationId = attributes["organizationId"]
      @countryCode = attributes["countryCode"]
      @userCount = attributes["userCount"]
      @currentAllowance = attributes["currentAllowance"]
      @nextAllowance = attributes["nextAllowance"]
      @maxOff = attributes["maxOff"]
      @bankHolidaySetId = attributes["bankHolidaySetId"]
    end

    def self.all(*args)
      conn = Faraday.new
      conn.authorization :Bearer, ENV["TIMETASTIC_API_TOKEN"]
      response = conn.get("#{API_URL}/departments")
      departments = JSON.parse(response.body)
      departments.map { |attributes| new(attributes) }
    end

    def self.find(id)
      conn = Faraday.new
      conn.authorization :Bearer, ENV["TIMETASTIC_API_TOKEN"]
      response = conn.get("#{API_URL}/departments/#{id}")
      attributes = JSON.parse(response.body)
      new attributes
    end
  end
end
