# frozen_string_literal: true

module Controlpanel
  class BaseController < ApplicationController
    layout "controlpanel"

    before_action :authenticate_user!
    before_action :require_admin!

    private

    def require_admin!
      return if current_user&.admin?

      redirect_to root_path, alert: "Access denied."
    end
  end
end
