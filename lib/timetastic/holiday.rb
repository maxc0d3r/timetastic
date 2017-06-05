module Timetastic
  class Holiday
    attr_accessor :id, :startDate, :startType, :endDate, :endType, :userId, :userName, :leaveTypeId, :duration, :deduction, :actionerId, :createdAt, :updatedAt, :reason, :declineReason, :status, :bookingUnit, :leaveType

    def initialize(attributes)
      @id = attributes["id"]
      @startDate = attributes["startDate"]
      @startType = attributes["startType"]
      @endDate = attributes["endDate"]
      @endType = attributes["endType"]
      @userId = attributes["userId"]
      @userName = attributes["userName"]
      @leaveTypeId = attributes["leaveTypeId"]
      @duration = attributes["duration"]
      @deduction = attributes["deduction"]
      @actionerId = attributes["actionerId"]
      @createdAt = attributes["createdAt"]
      @updatedAt = attributes["updatedAt"]
      @reason = attributes["reason"]
      @declineReason = attributes["declineReason"]
      @status = attributes["status"]
      @bookingUnit = attributes["bookingUnit"]
      @leaveType = attributes["leaveType"]
    end

    def self.all(options={},filters={})
      conn = Faraday.new
      conn.authorization :Bearer, ENV["TIMETASTIC_API_TOKEN"]
      response = conn.get("#{API_URL}/holidays")
      holidays = JSON.parse(response.body)["holidays"]
      filters.each do |k,v|
        holidays = holidays.select { |holiday| holiday[k] == v }
      end
      holidays.map { |attributes| new(attributes) }
    end

    def self.find(id)
      conn = Faraday.new
      conn.authorization :Bearer, ENV["TIMETASTIC_API_TOKEN"]
      response = conn.get("#{API_URL}/holidays/#{id}")
      attributes = JSON.parse(response.body)
      new attributes
    end
  end
end
