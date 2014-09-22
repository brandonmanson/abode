class Expense < ActiveRecord::Base
  belongs_to :payer, class_name: "User"
  has_many :user_expenses, dependent: :destroy
  has_many :users, through: :user_expenses
  has_one :dwelling, through: :payer
  has_many :comments, as: :commentable

  validates :name, :amount, presence: true
  validate :amount_must_be_distributed

  before_destroy :delete_owed_amounts

  def total_paid
    self.user_expenses.sum("paid")
  end

  def distribute_portions
    users = self.dwelling.users
    num_users = users.count
    users.each do |u|
      self.user_expenses << UserExpense.create(portion: self.amount / num_users, user_id: u.id )
    end
  end

  def amount_must_be_distributed
    if self.amount != self.user_expenses.reduce(0){|sum, e| sum = sum + e.portion}.round
      errors.add(:amount, "must be distributed fully among users sharing the expense")
    end
  end

  def delete_owed_amounts
    UserExpense.delete_all(expense_id: self.id)
  end
end
