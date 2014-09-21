class ExpensesController < ApplicationController
  def create
    @expense = Expense.new(expense_params)
    @expense.payer = current_user
    @expense.distribute_portions
    if @expense.save
      render partial: 'new', locals: {expense: Expense.new}
    else
      flash.now[:error] = "Expenses need a name and an amount"
      render partial: 'new', locals: {expense: @expense}
    end
  end

  def show
    @expense = Expense.find(params[:id])
    unless current_user.dwelling == @expense.dwelling
      @dwelling = current_user.dwelling
      redirect_to dwelling_show_path(@dwelling)
    end
    @comment = Comment.new
  end

  def index # used as ajax response
    @dwelling = Dwelling.find(current_user.dwelling_id)
    render partial: @dwelling.expenses
  end

  def edit
    @expense = Expense.find(params[:id])
    unless current_user.dwelling == @expense.dwelling
      @dwelling = current_user.dwelling
      redirect_to dwelling_show_path(@dwelling)
    end
  end

  def update
    @expense = Expense.find(params[:id])

    unless current_user.dwelling == @expense.dwelling
      @dwelling = current_user.dwelling
      redirect_to dwelling_show_path(@dwelling)
    end

    @expense.attributes = expense_params

    previous_portions = {}
    params[:user_expense].each do |id, expense_info|
      user_expense = UserExpense.find(id)
      previous_portions[id] = user_expense[:portion]
      user_expense.update(portion: expense_info[:portion])
    end

    new_user_expenses = []
    if params[:user_id] != nil
      params[:user_id].each do |user_id, expense_info|
        if expense_info[:portion].to_i > 0
          new_user_expenses << UserExpense.create(user_id: user_id, expense_id: @expense.id, portion: expense_info[:portion])
        end
      end
    end

    if @expense.save
      redirect_to expense_show_path(@expense)
      @expense.user_expenses.each do |user_expense|
        user_expense.destroy if user_expense[:portion] == 0
      end
    else
      previous_portions.each do |id, portion|
        user_expense = UserExpense.find(id)
        user_expense.update(portion: portion)
        new_user_expenses.each { |user_expense| user_expense.destroy }
      end
      flash.now[:error] = "Expense not updated"
      render 'edit'
    end
  end

  def destroy
    expense = Expense.find(params[:id])
    unless current_user.dwelling == expense.dwelling
      @dwelling = current_user.dwelling
      redirect_to dwelling_show_path(@dwelling)
    end
    dwelling = expense.dwelling
    expense.destroy
    redirect_to dwelling_show_path(dwelling)
  end

  private

  def expense_params
    params.require(:expense).permit(:name, :description, :amount, :payer_id)
  end
end
