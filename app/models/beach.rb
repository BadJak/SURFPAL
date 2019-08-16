class Beach < ApplicationRecord
  has_many :rides
  validates :name, presence: true
  validates :city, presence: true
end
