class Employee < ApplicationRecord
  belongs_to :company

  has_many :trips

  mount_uploader :avatar, AvatarUploader

  enum role: %i(major minor)
end
