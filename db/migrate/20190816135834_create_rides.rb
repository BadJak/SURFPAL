class CreateRides < ActiveRecord::Migration[5.2]
  def change
    create_table :rides do |t|
      t.date :date
      t.string :time_slot
      t.references :beach, foreign_key: true

      t.timestamps
    end
  end
end
