class User < ApplicationRecord
  validates :name, presence: true,length: { maximum: 15 }
   
  validates :email, presence: true,
                    format: {with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i}
  
  validates :image, presence: true
  
  mount_uploader :image, ImageUploader
  
  has_secure_password

  validates :password,presence: true,
                      length: { minimum: 8, maximum: 28 },
                      format: { with: /\A[a-zA-Z0-9]+\z/ }
                      
  has_many :topics
  has_many :favorites                   
                      
  has_many :favorites, dependent: :destroy
  has_many :favorite_topics, through: :favorites, source: 'topic', dependent: :destroy

  has_many :active_relationships, class_name: "Relationship",
                  foreign_key: "follower_id",
                  dependent: :destroy
                  
  has_many :passive_relationships, class_name: 'Relationship',
                  foreign_key: :followed_id, 
                  dependent: :destroy
  
  
  
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  
  def follow(other_user)
    active_relationships.create(followed_id: other_user.id)
  end
  
  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end
  
  def following?(other_user)
    following.include?(other_user)
  end
  
  def feed
  #   followed_user_ids = user.followed_user_ids
  #   where("user_id IN (?) OR user_id = ?", followed_user_ids, user)
  # end
   # 4. 別の書き方
    Topic.where(user_id: active_relationships.select(:followed_id))
      .or(Topic.where(user_id: id))
  end
end