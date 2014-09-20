class UserMailer < ActionMailer::Base
  default from: "owedtotheabode@gmail.com"

  def welcome_email(user)
    @user = user
    @url = "http://payrent.heroku.com"
    mail(to: @user.email, subject: 'Welcome!')
  end
end
