class BoardMailer < ActionMailer::Base
  default from: "admin@board.com"

  def user_banned_email(user)
    mail(:to => user.email, :subject => I18n.t('board_mailer.user_banned_email.user_banned_title'))
  end

  def photo_banned_email(protocol, host, photo, comment)
    @params = {image_link: photo.file.url, reason: comment, protocol: protocol, host: host}
    mail(:to => photo.item.seller.email, :subject => I18n.t('board_mailer.photo_banned_email.photo_banned_title'))
  end
end
