class Place < ActiveRecord::Base
  geocoded_by :address

  geocoded_by :full_address
  geocoded_by :address, latitude: :lat, longitude: :lon

  after_validation :geocode, if: ->(obj){ obj.address.present? and obj.address_changed? }

  after_validation :reverse_geocode, unless: ->(obj) { obj.address.present? },
                   if: ->(obj){ obj.latitude.present? and obj.latitude_changed? and obj.longitude.present? and obj.longitude_changed? }

  reverse_geocoded_by :latitude, :longitude do |obj, results|
    if geo = results.first
      obj.city    = geo.city
      obj.zipcode = geo.postal_code
      obj.country = geo.country_code
    end
  end

end
