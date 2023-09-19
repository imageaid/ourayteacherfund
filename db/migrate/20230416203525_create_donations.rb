class CreateDonations < ActiveRecord::Migration[7.0]
  def change
    create_table :donations do |t|
      t.references :user, null: false, foreign_key: true
      t.decimal :amount, default: 0.00
      t.boolean :recurring, default: false
      t.boolean :thanked, default: false
      t.date :received_on

      t.timestamps
    end
  end
end
