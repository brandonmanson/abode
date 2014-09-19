require 'rails_helper'
describe User do


  before(:each) do
    @test_dwelling = Dwelling.create!(address: "1238 W. Fulton", name: "winterfelyul", admin_id: 1 )
      @test_user1 = @test_dwelling.users.create!(name: "zac", email: "zacimitton22@gmail.com", phone: "8473341606", password: "password" )
        test_expense1 = @test_user1.expenses.create!(name: "rent", description: "the rent", amount: 2000.00 )
        test_expense2 = @test_user1.expenses.create!(name: "electric", description: "comed", amount: 100.00 )
      test_user2 = @test_dwelling.users.create!(name: "helin", email: "someitinn@gmail.com", phone: "7473341606", password: "password" )
        test_expense3 = test_user2.expenses.create!(name: "cable", description: "comcast", amount: 200.00 )
        test_expense4 = test_user2.expenses.create!(name: "water", description: "lake michigan", amount: 20.00 )
      test_user3 = @test_dwelling.users.create!(name: "brandon", email: "jhfgijfgh@gmail.com", phone: "6473341606", password: "password" )
      test_user4 = @test_dwelling.users.create!(name: "kyle", email: "sadfifdsa@gmail.com", phone: "5473341606", password: "password" )

    @test_user1.user_expenses.create!(expense_id: test_expense1.id, portion: 600.00, paid: 0)
    @test_user1.user_expenses.create!(expense_id: test_expense2.id, portion: 25.00, paid: 20)
    @test_user1.user_expenses.create!(expense_id: test_expense1.id, portion: 50.00, paid: 50)
    test_user4.user_expenses.create!(expense_id: test_expense1.id, portion: 400.00, paid: 400) 
  end

  it { should belong_to(:dwelling) }
  it { should have_many(:user_expenses) }
  it { should have_many(:expenses).with_foreign_key(:payer_id) }
  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email) }
  it { should ensure_length_of(:password).is_at_least(6) }

  describe '#email' do
    it 'should create a user with a valid email' do
      user = User.create(name: "Example User", email: "user@example.com",
                     password: "foobar", password_confirmation: "foobar")
      expect(user.id).should_not be_nil
    end

    it 'should not create a user with a invalid email' do
      user = User.create(name: "Example User", email: "userexample.com",
                     password: "foobar", password_confirmation: "foobar")
      expect(user.id).to be_nil
    end
  end

  describe "#authenticate" do
    it "can authenticate a user" do
      expect(@test_user1.authenticate("password")).to be_truthy
      expect(@test_user1.authenticate("fdlgjsfd")).to be_falsey
    end
  end
  describe "#total_expenses" do
    it "can show the user their total expense liability" do
      expect(@test_user1.total_expenses).to eq(675.00)
    end
  end
  describe "#total_owed" do
    it "can show the user how much left they currently owe" do
      expect(@test_user1.total_owed).to eq(605.00)
    end
  end
  describe "#total_paid" do
    it "can show the user how much of their total they have already paid" do
      expect(@test_user1.total_paid).to eq(70.00)
    end
  end

  describe "#create_remember token" do
    @user = User.create(name: "Example User", email: "user@example.com",
                     password: "foobar", password_confirmation: "foobar")

    it 'should have a token when created' do
      expect{@user.remember_token}.should_not be_nil
    end

    pending 'should have a different token after signout' do
      expect{@user.destroy}.to change{@user.remember_token}
    end
  end
end
