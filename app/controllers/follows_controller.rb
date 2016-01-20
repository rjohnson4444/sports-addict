class FollowsController < ApplicationController
  def create
    follow = Follow.new(follow_params)
    follow.user = current_user
    if follow.save
      StreamRails.feed_manager.follow_user(follow.user_id, follow.target_id)
    end
    flash[:success] = 'Followed!'
    redirect_to teams_path
  end

  def destroy
    follow = Follow.find(params[:id])
    if follow.user_id == current_user.id
      follow.destroy!
      StreamRails.feed_manager.unfollow_user(follow.user_id, follow.target_id)
    end
    flash[:success] = 'Unfollowed!'
    redirect_to teams_path
  end

  private
    def follow_params
      params.require(:follow).permit(:target_id)
    end
end
