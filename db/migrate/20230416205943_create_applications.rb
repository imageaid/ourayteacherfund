class CreateApplications < ActiveRecord::Migration[7.0]
  def change
    create_table :applications do |t|
      t.references :user, null: false, foreign_key: true
      t.string :school_year
      t.decimal :amount_requested
      t.integer :purpose
      t.string :other_purpose

      t.timestamps
    end
  end
end
