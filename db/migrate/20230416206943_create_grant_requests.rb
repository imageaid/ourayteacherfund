class CreateGrantRequests < ActiveRecord::Migration[7.0]
  def change
    create_table :grant_requests do |t|
      t.references :grant, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.string :school_year
      t.decimal :amount_requested
      t.jsonb :responses, default: {}

      t.timestamps
    end
  end
end
