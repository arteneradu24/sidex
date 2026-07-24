# frozen_string_literal: true

module Controlpanel
  class SeoSettingsController < BaseController
    before_action :set_site_setting

    def edit
    end

    def update
      if @site_setting.update(seo_params)
        redirect_to edit_controlpanel_seo_settings_path, notice: "SEO settings updated."
      else
        render :edit, status: :unprocessable_entity
      end
    end

    private

    def set_site_setting
      @site_setting = current_site
    end

    def seo_params
      params.require(:site_setting).permit(
        :site_title, :meta_description, :meta_keywords, :og_title, :og_description, :og_image
      )
    end
  end
end
