class Employee < ApplicationRecord
  belongs_to :company

  mount_uploader :avatar, AvatarUploader

  enum role: %i(major minor)
end
