# frozen_string_literal: true

class User < ApplicationRecord
  ROLES = { admin: 0, editor: 1, author: 2 }.freeze

  devise :database_authenticatable, :recoverable, :rememberable, :validatable

  enum :role, ROLES, default: :admin

  validates :role, presence: true

  def admin?
    role == "admin"
  end
end
