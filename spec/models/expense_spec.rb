require 'rails_helper'
describe Expense do

  before(:each) do
    test_dwelling = Dwelling.create!(address: "1238 W. Fulton", name: "winterfelyul", admin_id: 1 )
      @test_user1 = test_dwelling.users.create!(name: "zac", email: "zacimitton22@gmail.com", phone: "8473341606", password: "password" )
        @test_expense1 = @test_user1.expenses.create!(name: "rent", description: "the rent", amount: 2000.00 )
      @test_user2 = test_dwelling.users.create!(name: "helin", email: "someitinn@gmail.com", phone: "7473341606", password: "password" )
      @test_user3 = test_dwelling.users.create!(name: "brandon", email: "jhfgijfgh@gmail.com", phone: "6473341606", password: "password" )
      @test_user4 = test_dwelling.users.create!(name: "kyle", email: "sadfifdsa@gmail.com", phone: "5473341606", password: "password" )
    @test_user1.user_expenses.create!(expense_id: @test_expense1.id, portion: 600.00, paid: -10)
    @test_user2.user_expenses.create!(expense_id: @test_expense1.id, portion: 500.00, paid: 20)
    @test_user3.user_expenses.create!(expense_id: @test_expense1.id, portion: 500.00, paid: 0)
    @test_user4.user_expenses.create!(expense_id: @test_expense1.id, portion: 400.00, paid: 400)
  end


  it { should belong_to(:payer).class_name("User") }
  it { should have_many(:user_expenses) }
  it { should have_many(:users).through("user_expenses") }

  describe "#total_paid" do
    it "should return the total  paid on the expense" do
      expect(@test_expense1.total_paid).to eq(410)
    end
  end

  describe "#distribute_owed_amounts" do
    it "should distribute the amount of an expense evenly over its users" do
      @test_expense1.distribute_owed_amounts
      expect(@test_user1.user_expenses.sum(:portion)).to eq(500)
    end
  end

  describe "#distributed?" do
    it "should return true if all portions add up to expense total" do
      @test_expense1.distribute_owed_amounts
      expect(@test_expense1.distributed?).to eq(true)
    end
  end
end
