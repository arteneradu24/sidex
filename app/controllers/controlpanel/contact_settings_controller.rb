# frozen_string_literal: true

module Controlpanel
  class ContactSettingsController < BaseController
    before_action :set_site_setting

    def edit
    end

    def update
      if @site_setting.update(contact_params)
        redirect_to edit_controlpanel_contact_settings_path, notice: "Contact settings updated."
      else
        render :edit, status: :unprocessable_entity
      end
    end

    private

    def set_site_setting
      @site_setting = current_site
    end

    def contact_params
      params.require(:site_setting).permit(
        :phone, :email, :website, :street, :postal_code, :city, :country,
        :google_maps_url, :facebook_url, :instagram_url, :linkedin_url, :youtube_url
      )
    end
  end
end
