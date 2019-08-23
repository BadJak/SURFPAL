class UpdateRides < ActiveRecord::Migration[5.2]
  def change
    remove_column :rides, :scoring, :float
    add_column :rides, :rookie_score, :float
    add_column :rides, :beginner_score, :float
    add_column :rides, :advanced_score, :float
    add_column :rides, :pro_score, :float
  end
end
