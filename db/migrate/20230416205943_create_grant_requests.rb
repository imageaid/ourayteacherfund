class CreateGrantRequests < ActiveRecord::Migration[7.0]
  def change
    create_table :grant_requests do |t|
      t.references :user, null: false, foreign_key: true
      t.string :school_year
      t.decimal :amount_requested

      t.timestamps
    end
  end
end
