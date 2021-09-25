class ChangeDatatypeImageIdOfGroups < ActiveRecord::Migration[5.2]
  def change
    change_column :groups, :image_id, :string
  end
end
