# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path.
# Rails.application.config.assets.paths << Emoji.images_path
# Add Yarn node_modules folder to the asset load path.
Rails.application.config.assets.paths << Rails.root.join('node_modules')

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in the app/assets
Rails.application.config.assets.precompile += %w(ckeditor/filebrowser/images/gal_del.png)
Rails.application.config.assets.precompile += %w( ckeditor/* )
Rails.application.config.assets.precompile += %w( show_image.js )
Rails.application.config.assets.precompile += %w( search_booking.js )
Rails.application.config.assets.precompile += %w( search_routes.js )
Rails.application.config.assets.precompile += %w( search_employees.js )
# folder are already added.
# Rails.application.config.assets.precompile += %w( admin.js admin.css )
