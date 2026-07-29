# frozen_string_literal: true

module Controlpanel
  class SitePagesController < BaseController
    before_action :set_site_page, only: %i[edit update destroy publish unpublish]

    def index
      @site_pages = SitePage.ordered
    end

    def new
      @site_page = SitePage.new(position: next_position)
    end

    def create
      @site_page = SitePage.new(site_page_params)
      if @site_page.save
        redirect_to controlpanel_site_pages_path, notice: "Page created."
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit
    end

    def update
      if @site_page.update(site_page_params)
        redirect_to controlpanel_site_pages_path, notice: "Page updated."
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @site_page.destroy
      redirect_to controlpanel_site_pages_path, notice: "Page deleted."
    end

    def publish
      @site_page.update!(published: true)
      redirect_to controlpanel_site_pages_path, notice: "Page published."
    end

    def unpublish
      @site_page.update!(published: false)
      redirect_to controlpanel_site_pages_path, notice: "Page unpublished."
    end

    private

    def set_site_page
      @site_page = SitePage.find_by!(slug: params[:id])
    end

    def site_page_params
      params.require(:site_page).permit(
        :label, :slug, :hero_title, :hero_subtitle,
        :hero_button_text, :hero_button_url, :position,
        :published, :show_in_nav, :content, :hero_image,
        :main_title, :main_subtitle,
        :cta_title, :cta_subtitle, :cta_button_text, :cta_button_url, :show_cta
      )
    end

    def next_position
      (SitePage.maximum(:position) || 0) + 1
    end
  end
end
