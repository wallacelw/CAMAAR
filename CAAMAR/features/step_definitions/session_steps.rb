require 'Usuario'  # Add this line to manually require the file

Given('a user with email {string} and password {string} exists') do |email, password|
  @user = Usuario.new( 
  :email => email,
  :matricula => "123456",
  :password => password,
  :nome => 'Test User',
  :formacao => 'Test Formacao',
  :curso => 'Test Curso',
  :isAdmin => false,
  :isAluno => true,
  :isProf => false)
  
  @user.save!
  puts "User created with email: #{email} and password: #{password}"
end

Given('no user with email {string} and password {string} exists') do |email, password|
  Usuario.find_by(email: email, senha: password)&.destroy
end

When('I log in with email {string} and password {string}') do |email, password|
  visit new_session_path
  fill_in 'Email', with: email
  fill_in 'Password', with: password
  click_button 'Log in'
end

When('I log out') do
  click_link 'Logout'
end

Then('I should be redirected to the {string}') do |path|
  expect(current_path).to eq(path)
end

Then('I should see {string}') do |message|
  expect(page).to have_content(message)
end

Given('I am logged in as {string}') do |email|
  user = Usuario.find_by(email: email)
  visit new_session_path
  fill_in 'Email', with: email
  fill_in 'Password', with: user.senha
  click_button 'Log in'
end
