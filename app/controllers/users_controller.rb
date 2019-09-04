class UsersController < ApplicationController
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    # binding.pry
    if @user.save
      redirect_to root_path, success: '登録が完了しました'
    else
      flash.now[:danger] = '登録に失敗しました'
      render :new
    end
  end
 
  def index
    #URLにidがないのでnewにした
    @user = User.new
    @topic = current_user.topics.new
    @topic_feed = current_user.feed
  end 
  
  def show
    @user = User.find(params[:id])
    #binding.pry
    @topics = @user.topics
    # @topics = Topic.page(params[:page]).per(5)
  end
  
   def following
    @title = "Following"
    @user  = User.find(params[:id])
    #@users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user  = User.find(params[:id])
    #@users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end
  
  def all
    @user = User.all
  end
  
  def edit
    @user = User.find(current_user.id)
    #binding.pry
  end
  
  def update
    @user = User.find(current_user.id)
    if @user.update_attributes(user_params)
      redirect_to root_path, success: '登録が完了しました'
      # 更新に成功したときの処理
    else
      render 'edit'
    end
  end
  
  
  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :image, :password_confirmnation)
    # params.require(:user).permit(:name)
  end
end