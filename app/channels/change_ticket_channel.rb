class ChangeTicketChannel < ApplicationCable::Channel
  def subscribed
    stream_from "change_ticket_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
