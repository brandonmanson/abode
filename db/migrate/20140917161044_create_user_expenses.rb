class CreateUserExpenses < ActiveRecord::Migration
  def change
    create_table :user_expenses do |t|
      t.integer :user_id
      t.integer :expense_id
      t.decimal :portion, default: 0
      t.decimal :paid, default: 0

      t.timestamps
    end
  end
end
