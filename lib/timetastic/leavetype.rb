module Timetastic
  class LeaveType
    attr_accessor :id, :name, :deducted, :requiresApproval, :active, :organizationId, :createdAt, :updatedAt, :color

    def initialize(attributes)
      @id = attributes["id"]
      @name = attributes["name"]
      @deducted = attributes["deducted"]
      @requiresApproval = attributes["requiresApproval"]
      @active = attributes["active"]
      @organizationId = attributes["organizationId"]
      @createdAt = attributes["createdAt"]
      @updatedAt = attributes["updatedAt"]
      @color = attributes["color"]
    end

    def self.all(*args)
      conn = Faraday.new
      conn.authorization :Bearer, ENV["TIMETASTIC_API_TOKEN"]
      response = conn.get("#{API_URL}/leavetypes")
      leavetypes = JSON.parse(response.body)
      leavetypes.map { |attributes| new(attributes) }
    end

    def self.find(id)
      conn = Faraday.new
      conn.authorization :Bearer, ENV["TIMETASTIC_API_TOKEN"]
      response = conn.get("#{API_URL}/leavetypes/#{id}")
      attributes = JSON.parse(response.body)
      new attributes
    end
  end
end
