# encoding: UTF-8

require "spec_helper"

describe BoardMailer do
  describe '#user_banned_email' do

    it 'Отсылает письмо о том что пользователь заблокирован' do
      @user = FactoryGirl.create :user
      BoardMailer.user_banned_email(@user).deliver

      message = ActionMailer::Base.deliveries.last

      message.to.should include @user.email
      message.subject.should have_text I18n.t('board_mailer.user_banned_email.user_banned_title')
      message.body.should have_text I18n.t('board_mailer.user_banned_email.user_banned_title')
      message.body.should have_text I18n.t('board_mailer.user_banned_email.user_banned_message')
    end

  end

  describe '#photo_banned_email' do

    it 'Отсылает письмо о том что картинка заблокирована' do
      @user = FactoryGirl.create :user
      BoardMailer.photo_banned_email(@user).deliver

      message = ActionMailer::Base.deliveries.last

      message.to.should include @user.email
      message.subject.should have_text I18n.t('board_mailer.photo_banned_email.photo_banned_title')
      message.body.should have_text I18n.t('board_mailer.photo_banned_email.photo_banned_title')
      message.body.should have_text I18n.t('board_mailer.photo_banned_email.photo_banned_message')
    end

  end
end
