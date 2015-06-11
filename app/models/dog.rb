class Dog < ActiveRecord::Base
  belongs_to :user
  validates :name,  presence: true
  validates :breed,  presence: true
  validates :date_of_birth,  presence: true
end
