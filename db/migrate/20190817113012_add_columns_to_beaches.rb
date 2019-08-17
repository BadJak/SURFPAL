class AddColumnsToBeaches < ActiveRecord::Migration[5.2]
  def change
    add_column :beaches, :lon, :float
    add_column :beaches, :lat, :float
    add_column :beaches, :surfline_name, :string
    add_column :beaches, :surfline_id, :string
  end
end
