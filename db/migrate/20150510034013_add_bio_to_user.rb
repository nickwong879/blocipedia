class AddBioToUser < ActiveRecord::Migration
  def change
    add_column :users, :bio, :string
    add_column :users, :likes, :string
  end
end
