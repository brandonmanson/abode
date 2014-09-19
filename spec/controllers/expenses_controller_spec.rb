require 'rails_helper'

describe ExpensesController do
  before do
    @current_user = User.first
  end

  describe 'create expense' do
    # Not sure how to test this with ajax
    pending 'should render partial new when expense is created' do
      post :create, expense: { name: "Example", amount: 300 }
      expenct(response).to render_template('new')
    end
  end

  describe 'show expense details' do

    it 'should render details of expense' do
      get :show, id: Expense.first.id
      expect(response).to render_template(:show)
    end
  end

  # How to pass in current user for routes testing?
  describe 'get all expenses for an abode' do
    pending 'should render list of expenses' do
      get :index, current_user: @current_user
      expect(response).to render_partial()
    end
  end

  describe 'edit expense' do
    it 'should render edit form' do
      get :edit, id: Expense.first.id
      expect(response).to render_template(:edit)
    end
  end

  describe 'update expense' do
    it 'should redirect to expense show detail if edited successfully' do
      put :update, id: Expense.first.id, expense: { name: "Test update", amount: 400 }
      expect(response).to redirect_to(expense_show_path(assigns(:expense)))
    end

  end
end
