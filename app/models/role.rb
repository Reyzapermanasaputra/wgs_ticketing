class Role < ApplicationRecord
	validates :name, :code, presence: true
end
