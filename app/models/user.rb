class User < ActiveRecord::Base
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  before_create :create_remember_token
  has_secure_password
  belongs_to :dwelling
  has_many :expenses, foreign_key: :payer_id
  has_many :user_expenses
  has_many :comments
  has_many :emergency_contacts


  validates :email, presence: true, uniqueness: true, format: { with: VALID_EMAIL_REGEX }
  validates :password, length: { minimum: 6 }, on: :create

  def total_expenses
    self.user_expenses.reduce(0) { |sum, e| e.portion + sum}
  end

  def total_owed
    total_expenses - total_paid
  end

  def total_paid
    self.user_expenses.sum("paid")
  end

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.digest(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  def roommates
    self.dwelling.users.where.not(id: self.id)
  end

  def find_expense(expense)
    UserExpense.find_by(expense_id: expense.id, user_id: self.id)
  end

  private
  def create_remember_token
    self.remember_token = User.digest(User.new_remember_token)
  end

end
