class Mailer < ApplicationMailer
  default from: "wgsticketing@gmail.com"
  def send_ticket(recipient, maker, ticket)
  	@recipient = recipient
  	@maker = maker
  	@ticket = ticket
  	mail(to: recipient.email, subject: "no-reply [New Ticket Urgent]")
  end
end
