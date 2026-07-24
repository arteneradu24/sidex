# frozen_string_literal: true

module Controlpanel
  class GeneralSettingsController < BaseController
    before_action :set_site_setting

    def edit
    end

    def update
      if @site_setting.update(general_params)
        redirect_to edit_controlpanel_general_settings_path, notice: "General settings updated."
      else
        render :edit, status: :unprocessable_entity
      end
    end

    private

    def set_site_setting
      @site_setting = current_site
    end

    def general_params
      params.require(:site_setting).permit(
        :company_name, :company_tagline, :hero_title, :hero_subtitle,
        :hero_button_text, :hero_button_url, :home_label, :about_label,
        :services_label, :blog_label, :contact_label,
        :show_blog, :show_about, :show_services, :show_contact,
        :about_content, :services_content, :hero_image, :logo
      )
    end
  end
end
