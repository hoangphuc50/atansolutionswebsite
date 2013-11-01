class FixColumnName < ActiveRecord::Migration
  def change
    rename_column :users, :encrypted_password, :password_digest
    add_index :users, :email, unique: true
  end
end
