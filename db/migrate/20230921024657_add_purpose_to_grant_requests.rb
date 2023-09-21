class AddPurposeToGrantRequests < ActiveRecord::Migration[7.1]
  def change
    add_column :grant_requests, :purpose, :integer, default: 0
  end
end
