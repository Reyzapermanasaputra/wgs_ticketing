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
  validates :username, :contact, :address, :email, presence: true
  validates :email, format: { with: Devise.email_regexp, message: "invalid email" }

  def self.filter(params)
    role ||= Role.find_by_name(params[:search])
    code ||= Role.find_by_code(params[:search])
    if params[:search] == "true" || params[:search] == "false"
      self.where(is_active: params[:search])
    elsif role.present?
      self.where(role_id: role.id)
    elsif code.present?
      self.where(role_id: code.id)
    elsif params[:search].present?
      self.where("role_id is not null").where('username LIKE ? OR email LIKE ? OR contact LIKE ? OR address LIKE ?', "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%")
    else
      self.where("role_id is not null")
    end
  end
end
