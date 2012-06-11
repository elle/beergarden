ENV["RAILS_ENV"] = "test" # load test env
require File.expand_path('../../config/environment', __FILE__) # load application
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

  # Add more helper methods to be used by all tests here...
end


# require "minitest/autorun" # require minitest
# require 'capybara/rails'
# require 'minitest/matchers'
# require 'valid_attribute'
# require 'debugger'
# 
# # Turn like output reporter. More options, check: http://rubydoc.info/gems/minitest-reporters/0.4.0/file/README.md
# require 'minitest/reporters'
# MiniTest::Unit.runner = MiniTest::SuiteRunner.new
# MiniTest::Unit.runner.reporters << MiniTest::Reporters::SpecReporter.new
# 
# # Require ruby files in support dir.
# Dir[File.expand_path('test/support/*.rb')].each { |file| require file }
# 
# # Database cleaner.
# DatabaseCleaner.strategy = :truncation
# 
# class MiniTest::Spec
# 
#   # If repeating "FactoryGirl" is too verbose for you, so we can use build()
#   include FactoryGirl::Syntax::Methods
# 
#   # minitest-matchers. so we can use: have_valid()
#   include ValidAttribute::Method
# 
#   include Fakes
# 
#   before :each do
#     DatabaseCleaner.clean
#   end
# 
#   def show(object, label=nil)
#     ap "#{label}:" if label
#     ap object
#   end
# 
#   class << self
#     alias context describe
#   end
# end
# 
# # If description name ends with 'integration', use this IntegrationTest class.
# class IntegrationTest < MiniTest::Spec
#   include Rails.application.routes.url_helpers # to get url_helpers working
#   include Capybara::DSL # to get caoybara working
#   register_spec_type(/integration$/, self) # instruct minitest to use this class for the integration tests
# 
#   # https://github.com/plataformatec/devise/wiki/How-To:-Test-with-Capybara
#   # so we can `login_as(user, :scope => :user)`
#   # To make sure this works correctly you will need to reset warden after each test you can do this by calling
#   # Warden.test_reset!
#   # If for some reason you need to log out a logged in test user, you can use Warden's logout helper.
#   # logout(:user)
#   include Warden::Test::Helpers
#   Warden.test_mode!
# 
#   def admin
#     @admin ||= create(:admin_user)
#   end
# 
#   def sign_in_as(user)
#     visit '/users/sign_in' # or whatever log in path is
#     fill_in 'Email', :with => user.email
#     fill_in 'Password', :with => "sekret"
#     click_button "Sign in"
#   end
# 
#   def assert_authentication_required(msg=nil)
#     assert page.has_content?('You need to sign in before continuing'), msg
#   end
# 
#   def assert_authorisation_required(msg=nil)
#     assert page.has_content?('Unauthorised'), msg
#   end
# 
#   def assert_404(msg=nil)
#     assert page.has_content?('Page Not Found'), msg
#   end
# end

