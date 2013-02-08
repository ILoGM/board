class BoardMailer < ActionMailer::Base
  default from: current_user.email

  def user_banned_email(user)
    @user = user
    mail(:to => user.email, :subject => I18n.t(''))
  end

end
