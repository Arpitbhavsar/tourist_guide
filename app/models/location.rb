class Location < ActiveRecord::Base
  require 'csv'
  has_many :images, as: :imageable
  mount_uploader :image, ImageUploader
  accepts_nested_attributes_for :images, reject_if: :all_blank, allow_destroy: true

  # geocoded_by :address, latitude: :lat, longitude: :lon
  # after_validation :geocode

  geocoded_by :address   # can also be an IP address
  after_validation :geocode          # auto-fetch coordinates



      def self.import(file)
        CSV.foreach(file.path, headers: true) do |row|
          Location.create! row.to_hash
        end
      end

      def self.json_import(file)
        json_file = file.read
        location_list = JSON.parse(json_file)
        location_list.each do |location|
          Location.create(location.to_h)
        end
      end

      def address
        "#{self.name} #{self.state} #{self.zip_code}"
      end
    end
