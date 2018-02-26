class Project < ApplicationRecord
	has_many :clients, dependent: :destroy
	has_many :user_projects
	has_many :users, through: :user_projects
	has_many :tickets
	accepts_nested_attributes_for :clients, allow_destroy: true, reject_if: lambda {|attributes| attributes['contact'].blank?}
end
