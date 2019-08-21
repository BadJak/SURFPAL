class AddScoringToRides < ActiveRecord::Migration[5.2]
  def change
    add_column :rides, :scoring, :float
  end
end
