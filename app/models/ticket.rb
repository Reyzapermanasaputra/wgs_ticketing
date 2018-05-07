class Ticket < ApplicationRecord
	# has_many :user_tickets, dependent: :destroy
	# has_many :users, through: :user_tickets
	belongs_to :maker, class_name: 'User'
	belongs_to :recipient, class_name: 'User'
	belongs_to :header
	has_many :comments
	CATEGORY = ["Task", "Feature", "Bug", "Change Request"]
	PRIORITY = ["Trivial", "Low", "Normal", "High"]
	validates :title, :description, :category, :priority, :recipient_id, :maker_id, :header_id, :start_date, :end_date, presence: true
end
