# frozen_string_literal: true

module Controlpanel
  class MediaController < BaseController
    def index
      @attachments = ActiveStorage::Attachment.includes(:blob, :record).order(created_at: :desc)
    end

    def destroy
      attachment = ActiveStorage::Attachment.find(params[:id])
      attachment.purge
      redirect_to controlpanel_media_path, notice: "Media deleted."
    end
  end
end
