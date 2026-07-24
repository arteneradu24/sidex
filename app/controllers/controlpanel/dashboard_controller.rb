# frozen_string_literal: true

module Controlpanel
  class DashboardController < BaseController
    def index
      @posts_count = Post.count
      @published_posts_count = Post.where(published: true).count
      @new_messages_count = ContactMessage.where(status: :pending).count
      @recent_messages = ContactMessage.recent_first.limit(5)
      @recent_posts = Post.recent.limit(5)
    end
  end
end
