class Ticket < ApplicationRecord
	belongs_to :project
	has_many :user_tickets
	has_many :users, through: :user_tickets

end
