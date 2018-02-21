class TicketChannel < ApplicationCable::Channel
  def subscribed
    stream_from "ticket_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
