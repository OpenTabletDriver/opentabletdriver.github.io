require 'rubygems'
require 'bootstrap'

Jekyll::Hooks.register :site, :after_init do |site|
  # Ensure 'load_paths' is initialized
  site.config["sass"]["load_paths"] = [] if site.config["sass"]["load_paths"].nil?

  # Add Bootstrap stylesheets path
  site.config["sass"]["load_paths"] << Bootstrap.stylesheets_path

  # Add Bootswatch stylesheets path
  Gem.loaded_specs["bootswatch"].load_paths.each do |path|
    site.config["sass"]["load_paths"] << path
  end
end
