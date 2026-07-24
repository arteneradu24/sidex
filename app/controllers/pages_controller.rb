# frozen_string_literal: true

class PagesController < ApplicationController
  layout "public"

  def home
    @recent_posts = Post.published_posts.limit(3) if current_site.show_blog?
  end

  def about
    redirect_to root_path, alert: "Page not available." unless current_site.show_about?
  end

  def services
    redirect_to root_path, alert: "Page not available." unless current_site.show_services?
  end

  def contact
    redirect_to root_path, alert: "Page not available." unless current_site.show_contact?
    @contact_message = ContactMessage.new
  end
end
