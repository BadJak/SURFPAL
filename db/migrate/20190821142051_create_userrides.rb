class CreateUserrides < ActiveRecord::Migration[5.2]
  def change
    create_table :userrides do |t|
      t.references :ride, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
