# frozen_string_literal: true

module Controlpanel
  class ContactMessagesController < BaseController
    before_action :set_message, only: %i[show update destroy]

    def index
      @messages = ContactMessage.recent_first
      @new_count = ContactMessage.where(status: :pending).count
    end

    def show
      @message.update(status: :read) if @message.status_pending?
    end

    def update
      if @message.update(status: params[:status])
        redirect_to controlpanel_contact_messages_path, notice: "Message updated."
      else
        render :show, status: :unprocessable_entity
      end
    end

    def destroy
      @message.destroy
      redirect_to controlpanel_contact_messages_path, notice: "Message deleted."
    end

    private

    def set_message
      @message = ContactMessage.find(params[:id])
    end
  end
end
