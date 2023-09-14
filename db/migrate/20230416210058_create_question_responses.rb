class CreateQuestionResponses < ActiveRecord::Migration[7.0]
  def change
    create_table :question_responses do |t|
      t.references :question, null: false, foreign_key: true
      t.references :grant_request, null: false, foreign_key: true
      t.text :response

      t.timestamps
    end
  end
end
