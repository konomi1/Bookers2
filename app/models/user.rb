class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy

  has_many :active_relationships, class_name:"Relationship", foreign_key:'follower_id', dependent: :destroy
  has_many :followings, through: :active_relationships , source: :followed

  has_many :passive_relationships, class_name:"Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followers, through: :passive_relationships , source: :follower

  has_many :entries
  has_many :messages
  has_many :rooms, through: :entries


  attachment :profile_image

  validates :name, uniqueness: true, length: { in: 2..20 }
  validates :introduction, length: { maximum: 50 }

  def follow(user_id)
    active_relationships.create(followed_id: user_id)
  end

  def unfollow(user_id)
    active_relationships.find_by(followed_id: user_id).destroy
  end

  def following?(user)
    followings.include?(user)
  end

  # 集計
  def today_count
    books.where(created_at: Date.today.all_day).count
  end

  def yesterday_count
    books.where(created_at: 1.day.ago.all_day).count
  end

  def day_percent
    (today_count / yesterday_count.to_f * 100).round rescue "(前日の投稿が0のため計算できません)0"
  end

  def this_week
    books.where(created_at: 6.day.ago.beginning_of_day..Date.today.end_of_day).count
  end

  def last_week
    books.where(created_at: 2.week.ago.beginning_of_day..1.week.ago.end_of_day).count
  end

  def week_percent
    (this_week / last_week.to_f * 100).round rescue "(先週の投稿が0のため計算できません)0"
  end
  
end
