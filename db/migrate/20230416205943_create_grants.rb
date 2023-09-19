class CreateGrants < ActiveRecord::Migration[7.1]
  def change
    create_table :grants do |t|
      t.string :name
      t.text :details
      t.boolean :active, default: true
      t.text :questions, array: true, default: []

      t.timestamps
    end

    add_index :grants, :questions, using: :gin
  end
end
