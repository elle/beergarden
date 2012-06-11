# INTRO TO MINITEST
# ==========================================
# 01. Why Minitest?
# 02. Minitest vs. Rspec
# 03. Go over Gemfile
# 04. Go over test_helper
# 05. Go over our User model
# 06. Unit tests
# 07. Ways to run tests
# 08. Skipping tests
# 09. Seed value: `rake test:units TESTOPTS='--seed=28615'` to be in the same order
# 10. Run a single test
# 11. Integration tests



# Notes: 
# ==========================================
# test unit style using a class. for example:
# test method starting with test_ to make it a test method
# class UserTest < MiniTest::Unit::TestCase # need to inherit
#   def test_to_param
#   end
# end

# rspec style: can use describe and it blocks

# 07. Ways to run tests:
# % ruby -Itest test/unit/user_test.rb # include the test dir so it finds thetest_helper.rb
# % rake test TEST=test/unit/user_test.rb

# 10. Run a single test:
# % ruby -Itest test/unit/user_test.rb --name=/invalid_user/

# To print all possible options for Minitest, type
# % ruby -r minitest/autorun -e '' -- --help
# Output:
# minitest options:
#     -h, --help                       Display this help.
#     -s, --seed SEED                  Sets random seed
#     -v, --verbose                    Verbose. Show progress processing files.
#     -n, --name PATTERN               Filter test names on pattern (e.g. /foo/)





# 06. Unit tests
# ==========================================
require 'test_helper'

describe User do
  context 'when unsaved' do
    it 'invalid user' do
      u = User.new
      refute u.valid?
      assert_equal 3, u.errors.count
    end


    it 'valid user' do
      u = build(:user)
      assert u.valid?
      assert_equal 0, u.errors.count
    end
  end

  context "should have validations" do
    subject { User.new }

    it { must have_valid(:email).when('good@example.com') }
    it { wont have_valid(:email).when('', nil, 'invalid') }
    it { must have_valid(:first_name).when('john') }
    it { wont have_valid(:first_name).when('', nil) }
  end


  context 'when saved' do
    it 'should validate uniqueness of email' do
      first = create(:user)
      second = build(:user, :email => first.email) # unsaved

      assert !second.valid?
      assert_includes second.errors.messages[:email], 'has already been taken'
    end

    it '#full_name returns first and last name' do
      u = build(:user, :first_name => 'Joe', :last_name => 'Doe')
      u.full_name.must_equal 'Joe Doe'
    end
  end

  context 'with beer' do
    before { @user = create(:user) }

    it 'should keep track of beers drunk' do
      assert_equal 0, @user.consumed_count
      @user.drinks
      assert_equal 1, @user.consumed_count
    end

    it 'can become intoxicated' do
      2.times { @user.drinks }
      assert @user.can_have_another?
      @user.drinks
      assert @user.intoxicated?
    end

    it 'should implement responsible drinking' do
      3.times { @user.drinks }
      assert @user.intoxicated?
      @user.drinks
      # show @user.errors
      assert_includes @user.errors.messages[:base], 'You had enough beers tonight. May I suggest water?'
    end
  end
end


# 11. Integration tests
# page.text.must_include '...'
# ==========================================
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