# frozen_string_literal: true

module Controlpanel
  class PostsController < BaseController
    before_action :set_post, only: %i[show edit update destroy publish unpublish]

    def index
      @posts = Post.recent
    end

    def show
    end

    def new
      @post = Post.new
    end

    def create
      @post = Post.new(post_params)
      if @post.save
        redirect_to controlpanel_posts_path, notice: "Post created."
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit
    end

    def update
      if @post.update(post_params)
        redirect_to controlpanel_posts_path, notice: "Post updated."
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @post.destroy
      redirect_to controlpanel_posts_path, notice: "Post deleted."
    end

    def publish
      @post.publish!
      redirect_to controlpanel_posts_path, notice: "Post published."
    end

    def unpublish
      @post.unpublish!
      redirect_to controlpanel_posts_path, notice: "Post unpublished."
    end

    private

    def set_post
      @post = Post.find_by!(slug: params[:id])
    end

    def post_params
      params.require(:post).permit(:title, :slug, :excerpt, :published, :published_at, :content, :cover_image)
    end
  end
end
