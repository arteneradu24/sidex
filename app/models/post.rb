# frozen_string_literal: true

class Post < ApplicationRecord
  has_rich_text :content
  has_one_attached :cover_image

  validates :title, presence: true
  validates :slug, presence: true, uniqueness: true, format: { with: /\A[a-z0-9]+(?:-[a-z0-9]+)*\z/ }

  before_validation :generate_slug, if: -> { slug.blank? && title.present? }
  before_save :set_published_at, if: :published_changed?

  scope :published_posts, -> { where(published: true).where("published_at <= ?", Time.current).order(published_at: :desc) }
  scope :drafts, -> { where(published: false).order(updated_at: :desc) }
  scope :recent, -> { order(published_at: :desc, created_at: :desc) }

  def to_param
    slug
  end

  def publish!
    update!(published: true, published_at: Time.current)
  end

  def unpublish!
    update!(published: false)
  end

  private

  def generate_slug
    base = title.parameterize
    candidate = base
    counter = 1
    while Post.where.not(id: id).exists?(slug: candidate)
      candidate = "#{base}-#{counter}"
      counter += 1
    end
    self.slug = candidate
  end

  def set_published_at
    self.published_at = published? ? (published_at || Time.current) : nil
  end
end
