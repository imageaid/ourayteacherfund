class CreateMessages < ActiveRecord::Migration[7.1]
  def change
    create_table :messages do |t|
      t.string :subject
      t.datetime :sends_at
      t.integer :message_type, default: 0
      t.integer :status, default: 0
      t.text :deliver_to, array: true, default: []
      t.integer :total_delivered, default: 0

      t.timestamps
    end
  end
end
