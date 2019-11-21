class TicketJson
  attr_accessor :ticket_id, :code, :status

  def initialize(ticket_id, code, status)
    @ticket_id = ticket_id
    @code = code
    @status = status
  end
end
