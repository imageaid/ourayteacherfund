class CreateGrants < ActiveRecord::Migration[7.1]
  def change
    create_table :grants do |t|
      t.string :name
      t.text :details
      t.boolean :active, default: true
      t.jsonb :questions, default: []

      t.timestamps
    end
  end
end
