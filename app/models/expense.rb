class Expense < ActiveRecord::Base
  belongs_to :payer, class_name: "User"
  has_many :user_expenses, dependent: :destroy
  has_many :users, through: :user_expenses
  has_one :dwelling, through: :payer
  has_many :comments, as: :commentable

  accepts_nested_attributes_for :user_expenses
  validates :name, :amount, presence: true

  # after_save :distribute_owed_amounts
  # before_save :distributed?
  before_destroy :delete_owed_amounts

  # could belong to comment
  def total_paid
    self.user_expenses.sum("paid")
  end

  def distribute_owed_amounts
    users = self.dwelling.users
    num_users = users.count
    users.each do |u|
      if u.user_expenses.where(expense_id: self.id).length > 0
        u.user_expenses.find_by(expense_id: self.id).update(portion: self.amount / num_users )
      else
        u.user_expenses.create(expense_id: self.id, portion: self.amount / num_users)
      end
    end
  end

  def distributed?
    UserExpense.where(expense_id: self.id).sum(:portion) == self.amount
  end

  def redistribute_owed_amounts
    old_user_expense_total = self.user_expenses.sum("portion")
    if old_user_expense_total != self.amount
      self.user_expenses.each do |user_expense|
        user_expense.portion = (user_expense.portion/old_user_expense_total) * self.amount
        user_expense.save
      end
    end
  end

  def delete_owed_amounts
    UserExpense.delete_all(expense_id: self.id)
  end
end
