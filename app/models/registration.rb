class Registration < ActiveRecord::Base
  belongs_to :dog

  def valid_until
    created_at.to_date.months_since valid_for
  end
end
