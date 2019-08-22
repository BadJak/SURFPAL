class Userride < ApplicationRecord
  belongs_to :ride
  belongs_to :user
  validates :user, uniqueness: { scope: :ride,
      message: "Should only join ride once" }
end
