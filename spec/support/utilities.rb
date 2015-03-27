def go_home
  visit '/'
end

def login(user)
  visit '/'
  click_link 'Login'
  fill_in 'Login', with: user.username
  fill_in 'Password', with: user.password
  click_on 'Log in'
end

