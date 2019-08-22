class AddExperienceToRides < ActiveRecord::Migration[5.2]
  def change
    add_column :rides, :experience, :string
  end
end
