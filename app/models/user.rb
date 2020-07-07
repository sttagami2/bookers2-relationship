class User < ApplicationRecord
  #バリデーションは該当するモデルに設定する。エラーにする条件を設定できる。
  validates :name, length: {maximum: 20, minimum: 2}
  validates :introduction, length: {maximum: 50}
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


  has_many :active_relationships, class_name: "Relationship",
                  foreign_key: "follower_id",
                  dependent: :destroy
  # フォローしているユーザを一覧で表示（配列で取得)するための記述

  has_many :passive_relationships, class_name: "Relationship",
                  foreign_key: "followed_id",
                  dependent: :destroy
  # フォロワーの配列を展開するための記述

  has_many :following, through: :active_relationships,source: :followed
  # throughは1人に対していくつもの「フォローする/フォローされる」という多対多であるため使用
  # following配列の元はfollowed idの集合であるという意味
  has_many :followers, through: :passive_relationships, source: :follower

  
  has_many :books, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  attachment :profile_image, destroy: false


  # ユーザをフォローする
  def follow(other_user)
    active_relationships.create(followed_id: other_user.id)
  end

  # ユーザをアンフォローする
  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  # ユーザをフォローする
  def following?(other_user)
    following.include?(other_user)
  end

end
