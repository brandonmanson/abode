class ExpensesController < ApplicationController
  def create
    @expense = Expense.new(expense_params)
    @expense.payer = current_user
    if @expense.save
      @expense.distribute_owed_amounts
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
    # has_user_id([:id])
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
    if @expense.save
      @expense.redistribute_owed_amounts
      redirect_to expense_show_path(@expense)
    else
      render 'edit'
    end
  end

  def destroy
    expense = Expense.find(params[:id])
    unless current_user.dwelling == @expense.dwelling
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
