class AddColumnsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :age, :integer
    add_column :users, :level, :string
    add_column :users, :photo, :string
    add_column :users, :group_or_solo, :string
  end
end
