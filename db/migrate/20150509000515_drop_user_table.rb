class DropUserTable < ActiveRecord::Migration
  def change
  	remove_column :users, :password_hash, :string
  	remove_column :users, :password_salt, :string
  	remove_column :users, :password_digest, :string
  	remove_column :users, :confirm_token, :string
  	remove_column :users, :email_confirmed, :boolean, :default => false
  end
end
