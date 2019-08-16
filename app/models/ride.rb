class Ride < ApplicationRecord
  belongs_to :beach
  validates :date, presence: true
  validates :time_slot, presence: true

end
