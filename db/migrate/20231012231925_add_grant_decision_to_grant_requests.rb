class AddGrantDecisionToGrantRequests < ActiveRecord::Migration[7.1]
  def change
    add_reference :grant_requests, :grant_decision, null: true, foreign_key: true
  end
end
