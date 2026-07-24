# frozen_string_literal: true

class ContactMessage < ApplicationRecord
  STATUSES = { pending: 0, read: 1, archived: 2 }.freeze

  enum :status, STATUSES, default: :pending, prefix: :status

  validates :name, :email, :message, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

  scope :inbox, -> { where.not(status: :archived).order(created_at: :desc) }
  scope :recent_first, -> { order(created_at: :desc) }
end
