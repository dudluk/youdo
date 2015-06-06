class User < ActiveRecord::Base
  validates :name,  presence: true
  validates :email, presence: true
  validates :username, presence: true
  validates :password_digest, presence: true, length: { minimum: 12 }

  has_secure_password
end
