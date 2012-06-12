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

  context 'should have validations' do
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