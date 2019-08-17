class AddColumnsToRides < ActiveRecord::Migration[5.2]
  def change
    add_column :rides, :wave_height, :float
    add_column :rides, :swell_period, :float
    add_column :rides, :wind_speed, :float
    add_column :rides, :wind_direction, :float
    add_column :rides, :wind_gust, :float
  end
end
