class ChangeDefaultRoleValue < ActiveRecord::Migration
  def change
  	change_column_default(:users, :role, 1)
  end
end
