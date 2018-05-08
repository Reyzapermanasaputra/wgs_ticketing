class Project < ApplicationRecord
	has_many :clients, dependent: :destroy
	has_many :user_projects
	has_many :users, through: :user_projects
	has_many :headers, dependent: :destroy
	has_one :credential
	has_many :documents
	accepts_nested_attributes_for :clients, allow_destroy: false
	validates :name, :description, :presence => true
	scope :active, -> {where("is_active=true")}

	def self.filter(params)
		if params[:search] == "true" || params[:search] == "false"
      self.where(is_active: params[:search])
    elsif params[:search].present?
      self.where('name LIKE ? OR description LIKE ? ', "%#{params[:search]}%", "%#{params[:search]}%")
    else
      self.all
    end
  end
end
