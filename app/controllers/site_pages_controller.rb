# frozen_string_literal: true

class SitePagesController < ApplicationController
  layout "public"

  def show
    @site_page = SitePage.published_pages.find_by!(slug: params[:slug])
  end
end
