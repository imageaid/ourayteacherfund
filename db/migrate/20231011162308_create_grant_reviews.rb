class CreateGrantReviews < ActiveRecord::Migration[7.1]
  def change
    create_table :grant_reviews do |t|
      t.references :user, null: false, foreign_key: true
      t.references :grant_request, null: false, foreign_key: true

      t.timestamps
    end
  end
end
