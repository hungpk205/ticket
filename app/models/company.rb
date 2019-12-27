class Company < ApplicationRecord
  belongs_to :user

  has_many :employees, dependent: :destroy
  has_many :buses, dependent: :destroy
  has_many :routes, dependent: :destroy
  has_many :trips, dependent: :destroy
  has_many :notifications, dependent: :destroy

  validates :name, presence: true
  validates :logo, presence: true
  validates :banner, presence: true

  mount_uploader :logo, LogoUploader
  mount_uploader :banner, BannerUploader
end
