# frozen_string_literal: true

module Controlpanel
  class AppearanceSettingsController < BaseController
    before_action :set_site_setting

    def edit
    end

    def update
      if @site_setting.update(appearance_params)
        redirect_to edit_controlpanel_appearance_settings_path, notice: "Appearance updated."
      else
        render :edit, status: :unprocessable_entity
      end
    end

    private

    def set_site_setting
      @site_setting = current_site
    end

    def appearance_params
      params.require(:site_setting).permit(
        :primary_color, :secondary_color, :background_color, :text_color,
        :button_color, :button_text_color, :navbar_background_color,
        :footer_background_color
      )
    end
  end
end
