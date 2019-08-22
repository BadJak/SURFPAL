class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :userrides
  has_many :rides, through: :userrides

  has_many :messages

  has_many :reviews
  has_many :beaches, through: :reviews

  validates :username, presence: true, uniqueness: true
end
