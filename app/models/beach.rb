class Beach < ApplicationRecord
  has_many :rides

  has_many :reviews
  has_many :users, through: :reviews

  validates :name, presence: true
  validates :city, presence: true

  geocoded_by :name

  include PgSearch
  pg_search_scope :search_by_name_and_city,
    against: [ :name, :city ],
    using: {
      tsearch: { prefix: true } # <-- now `superman batm` will return something!
    }
end
