class AddPhotosToBeaches < ActiveRecord::Migration[5.2]
  def change
    add_column :beaches, :photo, :string
  end
end
