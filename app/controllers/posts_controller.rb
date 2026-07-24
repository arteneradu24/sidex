# frozen_string_literal: true

class PostsController < ApplicationController
  layout "public"

  before_action :set_post, only: :show

  def index
    redirect_to root_path, alert: "Blog not available." unless current_site.show_blog?
    @posts = Post.published_posts
  end

  def show
    redirect_to root_path, alert: "Blog not available." unless current_site.show_blog?
  end

  private

  def set_post
    @post = Post.published_posts.find_by!(slug: params[:id])
  end
end
