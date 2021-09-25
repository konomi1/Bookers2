class Group < ApplicationRecord
  has_many :group_users, dependent: :destroy
  has_many :users, through: :groups_users

  validates :name, presence: true
  validates :introduction, presence: true

  attachment :image
end
