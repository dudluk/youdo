class User < ActiveRecord::Base
  validates :name,  presence: true
  validates :email, presence: true
  validates :username, presence: true
  has_secure_password
  validates :password, length: { minimum: 12 }
end
