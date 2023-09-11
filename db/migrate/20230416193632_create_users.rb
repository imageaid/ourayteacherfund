class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.virtual :name, type: :string, as: "first_name || ' ' || last_name", stored: true
      t.string :email, null: false, index: { unique: true }
      t.string :type, null: false, default: 'User'
      t.string :slug, null: false, index: { unique: true }
      t.integer :role, default: 0
      t.boolean :active, default: true
      t.jsonb :meta, default: {}

      t.timestamps
    end
  end
end
