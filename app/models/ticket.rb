class Ticket < ApplicationRecord
	# has_many :user_tickets, dependent: :destroy
	# has_many :users, through: :user_tickets
	belongs_to :maker, class_name: 'User'
	belongs_to :recipient, class_name: 'User'
	belongs_to :header
	CATEGORY = ["Task", "Feature", "Bug", "Change Request"]
	PRIORITY = ["low", "Normal", "High", "Trivial"]

end
