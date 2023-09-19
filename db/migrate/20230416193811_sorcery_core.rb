class SorceryCore < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :crypted_password, :string, default: nil
    add_column :users, :salt, :string, default: nil
  end
end
