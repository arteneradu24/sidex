# frozen_string_literal: true

module AttachableImages
  extend ActiveSupport::Concern

  ALLOWED_CONTENT_TYPES = %w[image/png image/jpeg image/webp image/gif].freeze

  included do
    validate :validate_image_attachments
  end

  private

  def validate_image_attachments
    self.class.reflect_on_all_attachments.each do |attachment|
      file = public_send(attachment.name)
      next unless file.attached?
      next if ALLOWED_CONTENT_TYPES.include?(file.content_type)

      errors.add(attachment.name, "must be a PNG, JPEG, WebP, or GIF image")
    end
  end
end
