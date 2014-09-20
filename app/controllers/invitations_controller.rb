class InvitationsController < ApplicationController

  def new
    @invitation = Invitation.new
  end

  def create
    @invitation = Invitation.new(email: params[:invitation][:email])
    @invitation.dwelling = Dwelling.find(params[:abode_id])
    if @invitation.save
      InvitationMailer.invitation_email(@invitation).deliver
      flash.now[:message] = "Invitation successful!"
      redirect_to new_abode_invitation_path
    else
      flash.now[:message] = "Email not valid"
    end
  end

  def index
  end
end
