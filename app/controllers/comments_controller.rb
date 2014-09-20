class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end

  def create
    if request.original_url.include?("abodes")
      commentable = Dwelling.find(params[:abode_id])
    elsif request.original_url.include?("expenses")
      commentable = Expense.find(params[:expense_id])
    end
    comment = commentable.comments.new(comment_params)
    comment.assign_attributes(user_id: current_user.id)
    if comment.save
      redirect_to abode_path(params[:abode_id]) if commentable.is_a?(Dwelling)
      redirect_to expense_path(params[:expense_id]) if commentable.is_a?(Expense)
    else
      flash[:error] = "Description required"
      redirect_to abode_path(params[:abode_id]) if commentable.is_a?(Dwelling)
      redirect_to expense_path(params[:expense_id]) if commentable.is_a?(Expense)
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:description)
  end
end
