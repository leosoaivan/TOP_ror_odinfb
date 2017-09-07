class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def index
    if user_signed_in?
      @users = User.all_except(current_user)
    else
      flash[:error] = 'You must sign in or sign up to continue'
      redirect_to new_user_session_path
    end
  end

  def show
    @user = User.find(params[:id])
    @friendships = @user.all_friendships
    @pending_friendships = @user.received_friendships.where(accepted: false)
    @posts = @user.posts
  end
end
