class FriendshipsController < ApplicationController
  def create
    @friendship = current_user.friendships.build(friend_id: params[:friend_id])
    if @friendship.save
      flash[:notice] = "Added friend."
      redirect_to root_url
    else
      flash[:error] = "Unable to add friend."
      redirect_to root_url
    end
  end

  def update
    @friendship = current_user.received_friendships.find(params[:id])
    @friendship.update(accepted: "true")
    if @friendship.save
      redirect_to root_url, notice: "Successfully confirmed friend!"
    else
      redirect_to root_url, notice: "Sorry! Could not confirm friend!"
    end
  end

  def destroy
    begin
      @friendship = current_user.friendships.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      @friendship = current_user.received_friendships.find(params[:id])
    end
    @friendship.destroy
    flash[:notice] = "You've unfriended someone."
    redirect_to current_user
  end
end
