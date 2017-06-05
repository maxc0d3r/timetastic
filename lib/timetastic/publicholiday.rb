module Timetastic
  class PublicHoliday
    attr_accessor :id, :name, :date, :organizationId, :createdAt, :updatedAt, :countryCode

    def initialize(attributes)
      @id = attributes["id"]
      @name = attributes["name"]
      @date = attributes["date"]
      @organizationId = attributes["organizationId"]
      @createdAt = attributes["createdAt"]
      @updatedAt = attributes["updatedAt"]
      @countryCode = attributes["countryCode"]
    end

    def self.all(*args)
      conn = Faraday.new
      conn.authorization :Bearer, ENV["TIMETASTIC_API_TOKEN"]
      response = conn.get("#{API_URL}/publicholidays")
      publicholidays = JSON.parse(response.body)
      publicholidays.map { |attributes| new(attributes) }
    end

    def self.find(id)
      conn = Faraday.new
      conn.authorization :Bearer, ENV["TIMETASTIC_API_TOKEN"]
      response = conn.get("#{API_URL}/publicholidays/#{id}")
      attributes = JSON.parse(response.body)
      new attributes
    end
  end
end
