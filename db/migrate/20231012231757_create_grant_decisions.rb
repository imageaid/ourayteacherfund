class CreateGrantDecisions < ActiveRecord::Migration[7.1]
  def change
    create_table :grant_decisions do |t|
      t.references :grant_request, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.boolean :approved
      t.decimal :amount_awarded

      t.timestamps
    end
  end
end
