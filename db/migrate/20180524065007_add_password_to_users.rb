class AddPasswordToUsers < ActiveRecord::Migration
  def change
    add_column :users, :passwrod, :string
  end
end
