class BoardMailer < ActionMailer::Base
  default from: "admin@board.com"

  def user_banned_email(user)
    mail(:to => user.email, :subject => I18n.t(:user_banned_title))
  end

  def photo_banned_email(user)
    mail(:to => user.email, :subject => I18n.t(:photo_banned_title))
  end

end
