class UpdateUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :group_or_solo, :string
    add_column :users, :hometown, :string
    add_column :users, :bio, :text
  end
end
