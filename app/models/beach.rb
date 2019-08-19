class Beach < ApplicationRecord
  has_many :rides
  validates :name, presence: true
  validates :city, presence: true

  geocoded_by :city
    after_validation :geocode, if: :will_save_change_to_city?

  include PgSearch
  pg_search_scope :search_by_name_and_city,
    against: [ :name, :city ],
    using: {
      tsearch: { prefix: true } # <-- now `superman batm` will return something!
    }
end
