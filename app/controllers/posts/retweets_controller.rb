module Posts
  class RetweetsController < ApplicationController
    include ActionView::RecordIdentifier
    before_action :set_post
    def create
      current_user.retweets.create(post_id: @post.id)
      render turbo_stream: turbo_stream.update_all(".#{dom_id(@post, :retweet)}", partial: "posts/retweet_button", locals: { user: current_user, post: @post })
    end

    def destroy
      current_user.retweets.where(post_id: @post.id).destroy_all
      render turbo_stream: turbo_stream.update_all(".#{dom_id(@post, :retweet)}", partial: "posts/retweet_button", locals: { user: current_user, post: @post })
    end

    private

    def set_post
      @post = Post.find(params[:post_id])
    end
  end
end