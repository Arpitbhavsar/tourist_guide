require 'csv'

namespace :location_tasks do

  desc "This Task is to import the locations via JSON"
  task import_locations_json: :environment do
    location_list = JSON.parse(File.read('locations.json'))
    location_list.each do |location|
      Location.create(location.to_h)
    end
  end

  desc "This Task is to import the locations via CSV"
  task import_locations_csv: :environment do
    CSV.foreach('location.csv', headers: true) do |row|
      Location.create! row.to_hash
    end
  end

end
