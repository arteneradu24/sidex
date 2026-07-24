# frozen_string_literal: true

class ApplicationController < ActionController::Base
  allow_browser versions: :modern

  before_action :load_site_setting

  helper_method :current_site

  private

  def load_site_setting
    @site = current_site
  end

  def current_site
    @current_site ||= SiteSetting.current
  end
end
