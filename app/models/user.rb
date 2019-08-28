class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  after_create :send_welcome_email

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :userrides
  has_many :rides, through: :userrides

  has_many :messages

  has_many :reviews, dependent: :destroy
  has_many :beaches, through: :reviews

  validates :username, presence: true, uniqueness: true

  mount_uploader :photo, PhotoUploader



   private

   def send_welcome_email
     UserMailer.welcome(self).deliver_now
   end

end
