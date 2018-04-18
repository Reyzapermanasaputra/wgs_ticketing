class Header < ApplicationRecord
	belongs_to :project
	has_many :tickets
end
