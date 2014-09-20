class EmergencyContact < ActiveRecord::Base
  belongs_to :user
  has_one :dwelling, through: :user
  validates :name, :phone, :email, presence: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, format: { with: VALID_EMAIL_REGEX }
end
