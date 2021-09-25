class CreateGroupUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :group_users do |t|
      t.integer :user_id
      t.integer :owner_id

      t.timestamps
    end
  end
end
