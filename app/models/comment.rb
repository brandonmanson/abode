class Comment < ActiveRecord::Base
  validates :user_id, presence: true, numericality: true
  validates :type, presence: true, inclusion: { in: %w(dwelling expense) }
  validates :commentable_id, presence: true, numericality: true
  validates :description, presence: true
end
