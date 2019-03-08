require 'test_helper'
class User < ApplicationRecord
	before_save { email.downcase! }
	validates :name,  presence: true, length: { maximum: 50 }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 255 }
                           format: { with: VALID_EMAIL_REGEX }
                            uniqueness: true
                            uniqueness: { case_sensitive: false }
    has_secure_password
    validates :password, presence: true, length: { minimum: 6 }
    def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
end
class UserTest < ActiveSupport::TestCase
	def setup
    @user = User.new(name: "Example User", email: "user@example.com")
  end

  test "should be valid" do
    assert @user.valid?
  end
  test "name should be present" do
    @user.name = "     "
    assert_not @user.valid?
  end

  # test "the truth" do
  #   assert true
  # end
end