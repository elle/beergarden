class User < ActiveRecord::Base
  validates_presence_of :first_name

  validates :email, :presence => true,
                    :uniqueness => true,
                    :format => { :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i, :on => :create }

  validate :should_be_responsible

  scope :admins, where(:admin => true)

  ALLOWED_CONSUMPTION = 3

  def to_s
    full_name
  end

  def full_name
    [first_name,last_name].join(" ")
  end

  def likes_beer?
    first_name.downcase == 'lachlan' ? true : false
  end

  def drinks
    self.consumed_count += 1
    save
  end

  def can_have_another?
    consumed_count < ALLOWED_CONSUMPTION
  end

  def intoxicated?
    consumed_count >= ALLOWED_CONSUMPTION
  end

  private
  def should_be_responsible
    errors.add(:base, 'You had enough beers tonight. May I suggest water?') if intoxicated?
  end
end