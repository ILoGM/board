# encoding: UTF-8
def become_user(user)
  visit users_path
  click_link 'Become user'
end

def new_ban_user(user)
  visit users_path
  click_link 'Ban user'
end

def ban_user(user, comment)
  new_ban_user(user)

  fill_in 'Comment', with: comment

  click_button 'Create Admin comment'
end

def attach_photos_to_item(item, only_one = false)
  click_link I18n.t(:sign_out)
  sign_in_user item.seller

  click_link I18n.t(:add_photo)

  attach_file 'Изображение 1', Rails.root.join('spec', 'support', 'test_image_1.jpg')
  unless (only_one)
    attach_file 'Изображение 2', Rails.root.join('spec', 'support', 'test_image_2.jpg')
    attach_file 'Изображение 3', Rails.root.join('spec', 'support', 'test_image_3.jpg')
  end

  click_button 'Save changes'

  click_link I18n.t(:sign_out)
end

def new_ban_photo(item)
  only_one = true
  attach_photos_to_item(item, only_one)

  sign_in_user @user

  visit items_path

  click_link 'Ban photo'
end

def ban_photo(item, comment)
  new_ban_photo(item)

  fill_in 'Comment', with: comment

  click_button 'Create Admin comment'
end
