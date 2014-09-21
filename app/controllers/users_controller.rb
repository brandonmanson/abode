class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      # UserMailer.welcome_email(@user).deliver
      sign_in(@user)
      redirect_to "/users/#{@user.id}"
    else
      flash.now[:error] = "Try again"
      render :new
    end
  end

  def show
    set_user_or_redirect(params[:id])
    @user = User.find(params[:id])
  end

  def edit
    set_user_or_redirect(params[:id])
    @user = User.find(params[:id])
  end

  def update
    @user = current_user
    @user.attributes = user_params
    if @user.save
      redirect_to user_show_path(@user.id)
    else
      flash.now[:error] = "Try again"
      render :edit
    end
  end

  def join
    @dwelling = Dwelling.new
  end

  def add
    @dwelling = Dwelling.find_by(secret_key: params[:dwelling][:secret_key])
    if @dwelling != nil
      current_user.dwelling = @dwelling
      current_user.save
      redirect_to dwelling_show_path(@dwelling.id)
    else
      flash.now[:error] = "This is not a valid code"
      render :join
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :phone, :password, :password_confirmation, :dwelling_id)
    end
end
