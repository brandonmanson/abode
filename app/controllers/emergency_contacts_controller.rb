class EmergencyContactsController < ApplicationController
  def new
    @emergency_contact = EmergencyContact.new
  end

  def create
    @emergency_contact = EmergencyContact.new(emergency_contact_params)
    @emergency_contact.user = current_user
    if @emergency_contact.save
      redirect_to user_show_path(current_user)
    else
      flash.now[:error] = "Contact information is not valid"
      render 'new'
    end
  end

  def show
  end

  def edit
    @emergency_contact = EmergencyContact.find(params[:id])
    unless current_user.dwelling == @emergency_contact.dwelling
      @dwelling = current_user.dwelling
      redirect_to dwelling_show_path(@dwelling)
    end
  end

  def update
    @emergency_contact = EmergencyContact.find(params[:id])
    unless current_user.dwelling == @emergency_contact.dwelling
      @dwelling = current_user.dwelling
      redirect_to dwelling_show_path(@dwelling)
    end
    @emergency_contact.attributes = emergency_contact_params
    if @emergency_contact.save
      redirect_to user_show_path(current_user)
    else
      flash.now[:error] = "Contact information is not valid"
      render 'edit'
    end
  end

  def destroy
    EmergencyContact.find(params[:id]).destroy
    unless current_user.dwelling == @emergency_contact.dwelling
      @dwelling = current_user.dwelling
      redirect_to dwelling_show_path(@dwelling)
    end
    redirect_to user_show_path(current_user)
  end

  private

  def emergency_contact_params
    params.require(:emergency_contact).permit(:name, :email, :phone, :relationship)
  end
end
