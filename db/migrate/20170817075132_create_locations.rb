class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :name
      t.string :state
      t.string :city
      t.string :district
      t.string :zip_code
      t.string :about

      t.timestamps null: false
    end
  end
end
