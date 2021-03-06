class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one :company, dependent: :destroy

  validates :email, presence: true
  validates :fullname, presence: true
  validates :phone, presence: true

  mount_uploader :avatar, ProfileUploader

  enum role: %i(admin editor)

  scope :non_admin, ->{where role: :editor}
end
