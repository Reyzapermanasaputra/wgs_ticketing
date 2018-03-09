class HeaderTicket < ApplicationRecord
	self.table_name = "headers_tickets"
	belongs_to :ticket
	belongs_to :header
end
