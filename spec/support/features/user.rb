require 'rails_helper'
def sign_in
  visit '/'
  visit '/users/sign_in'
  fill_in 'Email', with: 'octavianrotari@example.com'
  fill_in 'Password', with: 'password'
  click_button 'Accedi'
end
