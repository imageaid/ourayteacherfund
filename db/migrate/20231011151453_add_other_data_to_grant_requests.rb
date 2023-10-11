class AddOtherDataToGrantRequests < ActiveRecord::Migration[7.1]
  def change
    add_column :grant_requests, :slug, :string, null: false
    add_column :grant_requests, :other_data, :text
  end
end
