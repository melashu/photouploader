class Photo < ApplicationRecord
  require "carrierwave/orm/activerecord"
  mount_uploader :photo_file, PhotoFileUploader
  serialize :photo_file, JSON
end
