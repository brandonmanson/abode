require 'rails_helper'

describe UsersController do
  describe 'sign up' do
    before { get :new }

    it 'should show sign up page without session active' do
      expect(response.status).to eq 200
      expect(response).to render_template(:new)
    end

    it 'should redirect to show page if user is created successfully' do
      post :create, user: {name: "User", email: "user@example.com", password: "password", password_confirmation: "password"}

      expect(response).to redirect_to(user_show_path(assigns(:user)))
    end

    it 'should render the page again if the user is not created successfully' do
      post :create, user: {name: "User", email: "user@example", password: "password", password_confirmation: "password"}

      expect(response).to render_template(:new)
    end
  end

  describe 'show' do
    before do
      @user = User.create(name: "User", email: "user@example.com", password: "password", password_confirmation: "password")
    end

    it 'should show user profile' do
      get :show, id: @user
      expect(response).to render_template(:show)
    end
  end

  describe 'edit' do
    before do
      @user = User.create(name: "User", email: "user@example.com", password: "password", password_confirmation: "password")
    end

    it 'should show edit page' do
      get :edit, id: @user
      expect(response).to render_template(:edit)
    end

    it 'should redirect to show page if edited successfully' do
      put :update, id: @user.id, user: {name: "User updated", email: "user@example.com", password: "password", password_confirmation: "password"}
      expect(response).to redirect_to(user_update_path(assigns(:user)))
    end

    # Password validation no longer works for update because we removed so that a person can be added to a dwelling. Best way to fix this situation - find another way to allow user to add dwelling (without supplying password) or find another way to validate password if user wants to update password?
    it 'should render edit page again if edited unsuccessfully' do
      put :update, id: @user.id, user: {name: "User updated", email: "user@example.com", password: "pass", password_confirmation: "pass"}
      expect(response).to render_template(:edit)
    end

  end
end
