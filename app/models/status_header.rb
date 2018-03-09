class StatusHeader < ApplicationRecord
	belongs_to :project
	has_many :tickets, through: :status_headers_tickets
	has_many :status_headers_tickets
end
