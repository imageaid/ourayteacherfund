class CreatePages < ActiveRecord::Migration[7.0]
  def change
    create_table :pages do |t|
      t.string :title
      t.string :keywords
      t.string :link_label
      t.string :slug
      t.boolean :welcome_content, default: false
      t.boolean :navigation, default: false
      t.integer :position

      t.timestamps

      t.index [ :title ], unique: true
      t.index [ :slug ], unique: true
      t.index [ :link_label ], unique: true
    end
  end
end
