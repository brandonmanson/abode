class Dwelling < ActiveRecord::Base
  has_many :users
  has_many :expenses, through: :users
  has_many :comments, as: :commentable
  has_many :invitations

  before_create :create_secret_key


  def total_expenses
    self.expenses.reduce(0){|sum, e| e.amount + sum }
  end

  def total_owed
    total_expenses - total_paid
  end

  def total_paid
    self.expenses.reduce(0) do |sum, expense|
      sum + expense.total_paid
    end
  end

  private

  def create_secret_key
    begin
      secret_key = SecureRandom.urlsafe_base64(12)
    end while Dwelling.find_by(secret_key: secret_key)
    self.secret_key = secret_key
  end
end
