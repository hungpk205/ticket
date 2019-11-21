class AvatarUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def default_url(*args)
    "/assets/fallback/" + [version_name, "default-image.jpeg"].compact.join('_')
  end

  def extension_whitelist
    %w(jpg jpeg gif png)
  end
end
