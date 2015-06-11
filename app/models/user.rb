class User < ActiveRecord::Base
  validates :name,  presence: true
  validates :email, presence: true
  validates :username, presence: true, uniqueness: true
  has_secure_password
  validates :password, length: { minimum: 12 }, :on => :create
  has_many :dogs, dependent: :destroy
end
