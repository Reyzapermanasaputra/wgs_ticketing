class User < ApplicationRecord
  belongs_to :role,optional: true
  has_many :user_projects
  has_many :projects, through: :user_projects
  has_many :user_tickets
  has_many :tickets, through: :user_tickets

  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable, :invitable
end
