class PostsController < ApplicationController

  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      flash[:success] = "Post created!"
      redirect_to dashboard_path
    else
      flash[:error] = @post.errors.full_messages.join(" ")
      redirect_to dashboard_path
    end
  end

  def destroy
    # A way to delete a posts
  end

  private

    def post_params
      params.require(:post).permit(:message)
    end
end
