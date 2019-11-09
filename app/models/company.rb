class Company < ApplicationRecord
  belongs_to :user

  has_many :employees
  has_many :buses
  has_many :routes
  has_many :trips
  has_many :notifications

  validates :name, presence: true
  validates :logo, presence: true
  validates :banner, presence: true

  mount_uploader :logo, LogoUploader
  mount_uploader :banner, BannerUploader
end
