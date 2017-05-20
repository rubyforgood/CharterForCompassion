def sign_in(user)
  visit '/'
  click_link "Log in"
  within("#new_user") do
    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'password'
  end
  click_button "Log in"
end
