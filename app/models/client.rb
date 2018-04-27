class Client < ApplicationRecord
	belongs_to :project
	validates :name, :contact, :address, presence: true
end
