class User < ApplicationRecord
  belongs_to :role
  has_many :user_projects
  has_many :projects, through: :user_projects
  has_many :user_tickets
  has_many :tickets, through: :user_tickets

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :invitable
end
