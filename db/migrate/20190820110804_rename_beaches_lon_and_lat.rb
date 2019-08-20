class RenameBeachesLonAndLat < ActiveRecord::Migration[5.2]
  def change
    rename_column :beaches, :lon, :longitude
    rename_column :beaches, :lat, :latitude
  end
end
