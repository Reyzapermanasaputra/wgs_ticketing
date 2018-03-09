class Ticket < ApplicationRecord
	has_many :user_tickets, dependent: :destroy
	has_many :users, through: :user_tickets
	
	has_and_belongs_to_many :headers

	CATEGORY = ["Task", "Feature", "Bug", "Change Request"]
	PRIORITY = ["low", "Normal", "High", "Trivial"]
end
