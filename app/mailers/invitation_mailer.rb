class InvitationMailer < ActionMailer::Base
  default from: "owedtotheabode@gmail.com"

  def invitation_email(invitation)
    @invitation = invitation
    @url = "http://localhost:3000"
    mail(to: @invitation.email, subject: "You've been invited to #{Dwelling.find(@invitation.dwelling_id).name}")
  end
end
