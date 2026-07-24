# frozen_string_literal: true

class SiteSetting < ApplicationRecord
  include AttachableImages

  has_one_attached :hero_image
  has_one_attached :logo
  has_one_attached :og_image

  validates :company_name, presence: true, on: :update
  validates :primary_color, :secondary_color, :background_color, :text_color,
            :button_color, :button_text_color, :navbar_background_color,
            :footer_background_color,
            format: { with: /\A#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})\z/, allow_blank: true }

  def self.current
    first || create!(default_attributes)
  end

  def self.default_attributes
    {
      company_name: "Your Company",
      company_tagline: "Professional solutions for your business",
      hero_title: "Welcome to Your Company",
      hero_subtitle: "We deliver exceptional services tailored to your needs.",
      hero_button_text: "Get Started",
      hero_button_url: "/contact",
      home_label: "Home",
      about_label: "About",
      services_label: "Services",
      blog_label: "Blog",
      contact_label: "Contact",
      site_title: "Your Company",
      meta_description: "Professional company website",
      about_content: "We are a dedicated team committed to excellence.",
      services_content: "Our comprehensive services help businesses grow and succeed."
    }
  end

  def css_variables
    {
      "--primary-color" => primary_color,
      "--secondary-color" => secondary_color,
      "--background-color" => background_color,
      "--text-color" => text_color,
      "--button-color" => button_color,
      "--button-text-color" => button_text_color,
      "--navbar-background-color" => navbar_background_color,
      "--footer-background-color" => footer_background_color
    }
  end
end
