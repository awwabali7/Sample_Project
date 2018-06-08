class RemovePasswrodFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :passwrod, :string
  end
end
