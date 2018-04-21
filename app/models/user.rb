class User < ApplicationRecord
  belongs_to :role,optional: true
  has_many :user_projects
  has_many :projects, through: :user_projects
  #has_many :user_tickets
  #has_many :tickets, through: :user_tickets
  has_many :tickets, foreign_key: :recipient_id
  has_many :notifications, foreign_key: :recipient_id
  has_many :comment
  serialize :title
  scope :active, -> {select(:id, "username as title").where("is_active = ?", true)}
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable, :invitable

  has_attached_file :avatar, styles: { medium: "300x300", thumb: "100x100" }
  #validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/
end
