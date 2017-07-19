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

    def self.all(options={},filters=[])
      conn = Faraday.new
      conn.authorization :Bearer, ENV["TIMETASTIC_API_TOKEN"]
      query_string = ''
      url = "#{API_URL}/holidays"
      if filters.length > 0
        url = url+'?'
        query_string=(filters[0 ... -1].each { |s| s << "&" } << filters[-1]).join('')
        url = url + query_string
      end
      puts "url = #{url}"
      response = conn.get(url)
      holidays = JSON.parse(response.body)["holidays"]
      holidays.map { |attributes| new(attributes) }
    end

    def self.find(id)
      conn = Faraday.new
      conn.authorization :Bearer, ENV["TIMETASTIC_API_TOKEN"]
      response = conn.get("#{API_URL}/holidays/#{id}")
      attributes = JSON.parse(response.body)
      new attributes
    end

    def self.book(from_date,to_date,from_time,to_time,reason,leave_type,email)
      conn = Faraday.new
      conn.authorization :Bearer, ENV["TIMETASTIC_API_TOKEN"]
      user_id = Timetastic::User.all({},{'email' => email}).first.id
      leave_type_id = Timetastic::LeaveType.all({},{'name' => leave_type}).first.id
      post_request = { :from => from_date, :to => to_date, :fromTime => from_time, :toTime => to_time, :reason => reason, :userOrDepartmentId => user_id, :bookFor => "User", :leaveTypeId => leave_type_id}
      response = conn.post("#{API_URL}/holidays", post_request)
      puts response.body
      json_response = JSON.parse(response.body)
    end
  end
end
