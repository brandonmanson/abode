require 'rails_helper'

describe UsersController do
  include Devise::TestHelpers

  describe 'sign up' do
    before { get :new }

    it 'should show sign up page without session active' do
      expect(response.status).to eq 200
      expect(response).to render_template(:new)
    end

    it 'should redirect to show page if user is created successfully' do
      post :create, user: {name: "User", email: "user@example.com", password: "password", password_confirmation: "password"}
      expect(response).to redirect_to(user_show_path(:user))
    end

    it 'should render the page again if the user is not created successfully' do
      post :create, user: {name: "User", email: "user@example", password: "password", password_confirmation: "password"}

      expect(response).to render_template(:new)
    end
  end

  describe 'show' do
    let(:user) { User.create(name: "User", email: "user@example.com", password: "password", password_confirmation: "password") }

    it 'should show user profile' do
      get :show, id: User.last.id
      expect(response).to render_template(:show)
    end
  end

  describe 'edit' do
    before do
      @user = User.create(name: "User", email: "user@example.com", password: "password", password_confirmation: "password")
    end

    it 'should show edit page' do
      get :edit, id: User.last.id
      expect(response).to render_template(:edit)
    end

    it 'should redirect to show page if edited successfully' do
      put :update, id: User.first.id, user: {name: "User updated", email: "user@example.com", password: "password", password_confirmation: "password"}
      expect(response).to redirect_to(user_update_path(assigns(:user)))
    end

    # Password validation no longer works for update because we removed so that a person can be added to a dwelling. Best way to fix this situation - find another way to allow user to add dwelling (without supplying password) or find another way to validate password if user wants to update password?
    it 'should render edit page again if edited unsuccessfully' do
      put :update, id: User.last.id, user: {name: "User updated", email: "user@example", password: "pass", password_confirmation: "pass"}
      expect(response).to render_template(:edit)
    end
  end

  describe 'join' do
    let(:user) { mock_model(User) }
    it 'should render page to join dwelling' do
      get :join
      expect(response).to render_template(:join)
    end

    xit 'should show take user to dwelling if user is added properly (mock rspec not working)' do
      expect_any_instance_of(User).to receive(:save)
    end

    it 'should take user to dwelling if user is added properly' do
      d = Dwelling.create(name: "Test abode")
      user = User.create(name: "User", email: "user@example.com", password: "password", password_confirmation: "password")
      :authenticate_user!
      allow(controller).to receive(:current_user) { user }
      put :add, dwelling: {secret_key: d.secret_key}
      expect(response).to redirect_to(dwelling_show_path(d.id))
    end

  end

  describe 'test of stub' do
    it 'should return true for stub' do
      User.any_instance.stub(name: "stubby person")

      u = User.new
      u.stub(:save).and_return(false)
      # u.name.should eq("stubby person")
      u.save.should eq(false)
    end
  end
end
