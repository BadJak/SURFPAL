class UpdateBeaches < ActiveRecord::Migration[5.2]
  def change
    remove_column :beaches, :city, :string
    remove_column :beaches, :surfline_name, :string
    remove_column :beaches, :surfline_id, :string
    add_column :beaches, :description, :text
    add_column :beaches, :country, :string
  end
end
