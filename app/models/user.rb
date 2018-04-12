class User < ApplicationRecord
  belongs_to :role,optional: true
  has_many :user_projects
  has_many :projects, through: :user_projects
  has_many :user_tickets
  has_many :tickets, through: :user_tickets
  has_many :notifications, foreign_key: :recipient_id
  serialize :title
  scope :active, -> {select(:id, "username as title").where("is_active = ?", true)}
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable, :invitable
end
