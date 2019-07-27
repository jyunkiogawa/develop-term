class CommentsController < ApplicationController
  def create
    topic = Topic.find(params[:topic_id])
    @comment = topic.comments.build(comment_params)
      if @comment.save
        flash[:success] = "コメントしました"
        redirect_back(fallback_location: topic_url(topic.id))
      else
        flash[:danger] = "コメントできません"
        redirect_back(fallback_location: topic_url(topic.id))
      end 
  end
  
  def destroy
    
    topic = Topic.find(params[:topic_id])
      @comment = topic.comments.find(params[:id])
      @comment.destroy
        redirect_back(fallback_location: favorites_index_path)
  end 
  
  private
  def comment_params
    params.require(:comment).permit(:content)
  end 
end
