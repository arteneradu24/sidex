# frozen_string_literal: true

class SitePage < ApplicationRecord
  include AttachableImages

  RESERVED_SLUGS = %w[
    about services contact posts pages users controlpanel up admin
  ].freeze

  has_rich_text :content
  has_one_attached :hero_image

  validates :label, presence: true
  validates :slug, presence: true, uniqueness: true,
                   format: { with: /\A[a-z0-9]+(?:-[a-z0-9]+)*\z/ },
                   exclusion: { in: RESERVED_SLUGS, message: "is reserved" }
  validates :position, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  before_validation :generate_slug, if: -> { slug.blank? && label.present? }

  scope :published_pages, -> { where(published: true) }
  scope :in_navigation, -> { where(show_in_nav: true) }
  scope :nav_pages, -> { published_pages.in_navigation.order(:position, :label) }
  scope :ordered, -> { order(:position, :label) }

  def to_param
    slug
  end

  private

  def generate_slug
    base = label.parameterize
    candidate = base
    counter = 1
    while SitePage.where.not(id: id).exists?(slug: candidate)
      candidate = "#{base}-#{counter}"
      counter += 1
    end
    self.slug = candidate
  end
end
