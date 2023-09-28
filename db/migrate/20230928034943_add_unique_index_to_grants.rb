class AddUniqueIndexToGrants < ActiveRecord::Migration[7.1]
  def change
    add_index :grants, :active, unique: true
    add_index :grants, :name, unique: true
  end
end
