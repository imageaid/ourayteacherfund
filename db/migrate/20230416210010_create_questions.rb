class CreateQuestions < ActiveRecord::Migration[7.0]
  def change
    create_table :questions do |t|
      t.string :question
      t.boolean :active
      t.integer :position, default: 1

      t.timestamps
    end
  end
end
