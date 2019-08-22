class AddSwellToRides < ActiveRecord::Migration[5.2]
  def change
    add_column :rides, :swell_height, :float
    add_column :rides, :swell_direction, :float
  end
end
