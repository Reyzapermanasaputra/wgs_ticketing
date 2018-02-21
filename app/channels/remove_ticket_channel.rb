class RemoveTicketChannel < ApplicationCable::Channel
  def subscribed
    stream_from "remove_ticket_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
