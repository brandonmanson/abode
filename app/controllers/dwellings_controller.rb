class DwellingsController < ApplicationController
  def new
    @dwelling = Dwelling.new
  end

  def create
    @dwelling = Dwelling.new(dwelling_params)
    @dwelling.admin_id = current_user.id
    if @dwelling.save
      u = User.find(current_user.id)
      u.update(dwelling_id: @dwelling.id)
      redirect_to dwelling_show_path(@dwelling.id)
    else
      flash.now[:error] = "sorry that didn't save. Try again"
      render 'new'
    end
  end

  def show
    if current_user && current_user.dwelling.id.to_s == params[:id]
      @dwelling = Dwelling.find(params[:id])
      @comment = Comment.new
    else
      redirect_to signin_path
    end
  end

  def edit
    if current_user && current_user.dwelling.id.to_s == params[:id]
      @dwelling = Dwelling.find(params[:id])
    else
      redirect_to signin_path
    end
  end

  def update
    if current_user && current_user.dwelling.id.to_s == params[:id]
      @dwelling = Dwelling.find(params[:id])
      @comment = Comment.new
    else
      redirect_to signin_path
    end
    @dwelling.attributes = dwelling_params
    if @dwelling.save
      redirect_to action: "show", id: @dwelling.id
    else
      flash.now[:error] = "Try again"
      render :edit
    end
  end

  private

  def dwelling_params
    params.require(:dwelling).permit(:name, :address)
  end

end

