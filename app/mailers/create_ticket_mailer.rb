class CreateTicketMailer < ApplicationMailer
  default from: "wgsticketing@gmail.com"
  def send_ticket(recipient, maker)
  	mail(to: recipient.email, subject: "no-reply [New Ticket]")
  end
end
