class FavoritesController < ApplicationController
  def index
    @favorite_topics = current_user.favorite_topics
    #課題用追記
    @comment = Comment.new
  end

  def create
    favorite = Favorite.new(user_id: current_user.id, topic_id: params[:topic_id])
    # favorite.user_id = current_user.id
    # favorite.topic_id = params[:topic_id]
# binding.pry
    if favorite.save
      redirect_to topics_path, success: 'お気に入りに登録しました'
    else
      redirect_to topics_path, danger: 'お気に入りに登録に失敗しました'
    end
  end
  
  def destroy
    favorite = Favorite.find_by(user_id: current_user.id, topic_id: params[:topic_id])
    
    if favorite.destroy
      redirect_to topics_path, success: 'お気に入りを削除しました'
    end
  end  
end
