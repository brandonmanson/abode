class EmergencyContact < ActiveRecord::Base
  belongs_to :user
  validates :name, :phone, :email, presence: true
  validates :email, format: { with: VALID_EMAIL_REGEX }
end
