require 'rails_helper'
describe Dwelling do

  before(:each) do
    @test_dwelling = Dwelling.create!(address: "1238 W. Fulton", name: "winterfelyul", admin_id: 1 )
      test_user1 = @test_dwelling.users.create!(name: "zac", email: "zacimitton22@gmail.com", phone: "8473341606", password: "password" )
        test_expense1 = test_user1.expenses.create!(name: "rent", description: "the rent", amount: 2000.00 )
        test_expense2 = test_user1.expenses.create!(name: "electric", description: "comed", amount: 100.00 )
      test_user2 = @test_dwelling.users.create!(name: "helin", email: "someitinn@gmail.com", phone: "7473341606", password: "password" )

    test_user1.user_expenses.create!(expense_id: test_expense1.id, portion: 500.00, paid: 20)
    test_user2.user_expenses.create!(expense_id: test_expense1.id, portion: 400.00, paid: 400) 
  end

  it 'should have_many users' do
    expect(@test_dwelling).to have_many(:users)
  end

  it 'should have_many expenses through users' do
    expect(@test_dwelling).to have_many(:expenses).through(:users)
  end

  it { should have_many(:expenses).through(:users) }

  describe "#total_expenses" do
    it "should return the total of all expenses for the dwelling" do
      @test_dwelling
      expect(@test_dwelling.total_expenses).to eq(2100)
    end
  end
  describe "#total_owed" do
    it "should return the total of all expenses for the dwelling" do
      @test_dwelling
      expect(@test_dwelling.total_owed).to eq(1680)
    end
  end
  describe "#total_paid" do
    it "should return the total of all expenses for the dwelling" do
      @test_dwelling
      expect(@test_dwelling.total_paid).to eq(420)
    end
  end

end
