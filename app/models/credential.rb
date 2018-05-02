class Credential < ApplicationRecord
	validates :title, :body, presence: true
end
