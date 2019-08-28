class AddWeatherToRides < ActiveRecord::Migration[5.2]
  def change
    add_column :rides, :air_temp, :integer
    add_column :rides, :water_temp, :integer
    add_column :rides, :wind_compass, :string
    add_column :rides, :swell_compass, :string
    add_column :rides, :weather_description, :string
    add_column :rides, :cloud_cover, :integer
  end
end
