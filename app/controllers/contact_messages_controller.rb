# frozen_string_literal: true

class ContactMessagesController < ApplicationController
  layout "public"

  def create
    @contact_message = ContactMessage.new(contact_message_params)

    if @contact_message.save
      redirect_to contact_path, notice: "Thank you! Your message has been sent."
    else
      render template: "pages/contact", status: :unprocessable_entity
    end
  end

  private

  def contact_message_params
    params.require(:contact_message).permit(:name, :email, :phone, :subject, :message)
  end
end
