class Topic < ApplicationRecord
  validates :description, presence: true
  validates :image, presence: true
  
  belongs_to :user
  
  mount_uploader :image, ImageUploader
  
  has_many :favorites, dependent: :destroy

  # def  favorites 
  #   Favorite.where(topic_id: id)
    
  # end
  has_many :favorite_users, through: :favorites, source: 'user'
  def favorite_users
    users = []
    favorites = Favorite.where(topic_id: id)
    favorites.each do |favorite|
      users << User.find_by(id: favorite.user_id)
    end
    return users
  end
  
  has_many :comments, dependent: :destroy
end
