module Posts
  class LikesController < ApplicationController
    before_action :set_post
    include ActionView::RecordIdentifier
    def create
      current_user.likes.create(post_id: @post.id)
      render turbo_stream: turbo_stream.update_all(".#{dom_id(@post, :like)}", partial: "posts/like_button", locals: { post: @post, user: current_user })
    end

    def destroy
      like = @post.likes.where(user_id: current_user.id).last
      like.destroy!
      render turbo_stream: turbo_stream.update_all(".#{dom_id(@post, :like)}", partial: "posts/like_button", locals: { post: @post, user: current_user })
    end

    private

    def set_post
      @post = Post.find(params[:post_id])
    end
  end
end