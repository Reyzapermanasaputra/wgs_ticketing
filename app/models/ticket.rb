class Ticket < ApplicationRecord
	belongs_to :project
	has_many :user_tickets, dependent: :destroy
	has_many :users, through: :user_tickets

end
