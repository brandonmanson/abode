class Comment < ActiveRecord::Base
  belongs_to :commentable, polymorphic: true

  validates :user_id, presence: true, numericality: true
  validates :commentable_type, presence: true, inclusion: { in: %w(Dwelling Expense) }
  validates :commentable_id, presence: true, numericality: true
  validates :description, presence: true
end
