class Dog < ActiveRecord::Base
  belongs_to :user
  has_many :registrations, dependent: :delete_all

  validates :name,  presence: true
  validates :breed,  presence: true
  validates :date_of_birth,  presence: true

  def registered_until
    latest_registration = registrations.last
    !latest_registration ? nil : latest_registration.valid_until
  end
end
