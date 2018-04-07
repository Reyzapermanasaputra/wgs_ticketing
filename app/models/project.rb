class Project < ApplicationRecord
	has_many :clients, dependent: :destroy
	has_many :user_projects
	has_many :users, through: :user_projects
	has_many :headers
	has_one :credential
	has_many :documents
	accepts_nested_attributes_for :clients, allow_destroy: true, reject_if: lambda {|attributes| attributes['contact'].blank?}
	validates :name, :description, :presence => true
	scope :active, -> {where("is_active=true")}
end
