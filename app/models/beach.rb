class Beach < ApplicationRecord
  has_many :rides

  has_many :reviews, dependent: :destroy
  has_many :users, through: :reviews

  validates :name, presence: true
  validates :longitude, presence: true
  validates :latitude, presence: true

  geocoded_by :name
  mount_uploader :photo, PhotoUploader

  include PgSearch
  pg_search_scope :search_by_name,
    against: [ :name],
    using: {
      tsearch: { prefix: true } # <-- now `superman batm` will return something!
    }
end
