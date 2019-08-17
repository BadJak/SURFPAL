class Beach < ApplicationRecord
  has_many :rides
  validates :name, presence: true
  validates :city, presence: true

  include PgSearch
  pg_search_scope :search_by_name_and_city,
    against: [ :name, :city ],
    using: {
      tsearch: { prefix: true } # <-- now `superman batm` will return something!
    }
end
