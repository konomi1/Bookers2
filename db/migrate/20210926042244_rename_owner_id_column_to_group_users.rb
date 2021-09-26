class RenameOwnerIdColumnToGroupUsers < ActiveRecord::Migration[5.2]
  def change
    rename_column :group_users, :owner_id, :group_id
  end
end
