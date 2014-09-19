class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end

  def create
    @dwelling = Dwelling.find(params[:abode_id])
    comment = @dwelling.comments.new(comment_params)
    comment.assign_attributes(user_id: current_user.id)
    if comment.save
      redirect_to abode_path(params[:abode_id])
    else
      flash[:error] = "Description required"
      redirect_to abode_path(params[:abode_id])
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:description)
  end
end
