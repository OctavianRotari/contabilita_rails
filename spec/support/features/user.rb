require 'rails_helper'
def sign_up
  visit '/'
  visit '/users/sign_up'
  fill_in 'Email', with: 'test@test.com'
  fill_in 'Password', with: 'testtest'
  fill_in 'Password confirmation', with: 'testtest'
  click_button 'Sign up'
end
