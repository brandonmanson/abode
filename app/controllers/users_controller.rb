class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in(@user)
      redirect_to user_show_path(@user.id)
    else
      flash.now[:error] = "Try again"
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find_by(email: params[:user][:email])
    @user.attributes = user_params
    if @user.save
      redirect_to user_show_path(@user.id)
    else
      flash.now[:error] = "Try again"
      render :edit
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :phone, :password, :password_confirmation)
    end
end
