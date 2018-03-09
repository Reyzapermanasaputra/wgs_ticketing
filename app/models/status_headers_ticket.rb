class StatusHeadersTicket < ApplicationRecord
	belongs_to :ticket
	belongs_to :status_header
end
