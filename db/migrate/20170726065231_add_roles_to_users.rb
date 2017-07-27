class AddRolesToUsers < ActiveRecord::Migration
  def change
    add_column :users, :roles, :string, :default => "blogger", :null => false
  end
end
