require 'test_helper'

describe 'users integration' do
  it 'should be able to create a new user' do
    visit new_user_path
    fill_in 'First name', :with => 'Buzz'
    fill_in 'Last name', :with => 'Lightyear'
    fill_in 'Email', :with => 'buzz@lightyear.com'
    click_button 'Create User'
    # save_and_open_page
    assert page.has_content?('User was successfully created')
    # show User.last
    assert_equal 'buzz@lightyear.com', User.last.email
  end

  it 'should display errors' do
    visit new_user_path
    click_button 'Create User'
    assert page.has_content?('3 errors prohibited this user from being saved')
    assert page.has_content?("First name can't be blank")
    assert page.has_content?("Email can't be blank")
    assert page.has_content?("Email is invalid")
  end
end