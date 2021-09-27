class Book < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :book_favorites, through: :favorites , source: :user
  has_many :book_comments, dependent: :destroy

  is_impressionable counter_cache: true

  validates :title, presence: true
  validates :body, presence: true,  length: { maximum: 200 }

  validates :rate, numericality: {grater_than_or_equal_to: 1, less_than_equal_to: 5}, presence: true


  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

    scope :day_book_count, -> (count){ where(created_at: (count).day.ago.all_day).count}

end