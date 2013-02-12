# encoding: UTF-8

require "spec_helper"

describe BoardMailer do
  describe '#user_banned_email' do

    it 'Отсылает письмо о том что пользователь заблокирован' do
      @user = FactoryGirl.create :user
      comment = Faker::Lorem.sentence

      BoardMailer.user_banned_email(@user, comment).deliver

      message = ActionMailer::Base.deliveries.last

      message.to.should include @user.email
      message.subject.should have_text I18n.t('board_mailer.user_banned_email.user_banned_title')
      message.body.should have_text I18n.t('board_mailer.user_banned_email.user_banned_title')
      message.body.should have_text I18n.t('board_mailer.user_banned_email.user_banned_message')
      message.body.should have_text comment
    end
  end


  describe '#photo_banned_email' do

    it 'Отсылает письмо о том что картинка заблокирована' do
      @photo = FactoryGirl.create :photo
      @comment = Faker::Lorem.sentence
      PROTOCOL = 'http://'
      HOST_WITH_PORT = 'localhost:3000/'

      BoardMailer.photo_banned_email(PROTOCOL, HOST_WITH_PORT, @photo, @comment).deliver

      message = ActionMailer::Base.deliveries.last

      message.to.should include @photo.item.seller.email
      message.subject.should have_text I18n.t('board_mailer.photo_banned_email.photo_banned_title')
      message.body.should have_text I18n.t('board_mailer.photo_banned_email.photo_banned_title')
      message.body.should have_text I18n.t('board_mailer.photo_banned_email.photo_banned_message')
      message.body.should have_text I18n.t('board_mailer.photo_banned_email.photo_banned_link')
      message.body.should have_link @photo.file
      message.body.should have_text I18n.t('board_mailer.photo_banned_email.photo_banned_reason', reason: @comment)
      message.body.should have_text @comment
    end

  end
end
