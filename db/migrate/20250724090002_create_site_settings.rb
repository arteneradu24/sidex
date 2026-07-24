# frozen_string_literal: true

class CreateSiteSettings < ActiveRecord::Migration[8.1]
  def change
    create_table :site_settings do |t|
      # Company
      t.string :company_name
      t.string :company_tagline
      t.string :hero_title
      t.text :hero_subtitle
      t.string :hero_button_text
      t.string :hero_button_url

      # Navigation labels
      t.string :home_label, default: "Home"
      t.string :about_label, default: "About"
      t.string :services_label, default: "Services"
      t.string :blog_label, default: "Blog"
      t.string :contact_label, default: "Contact"

      # Contact
      t.string :phone
      t.string :email
      t.string :website
      t.string :street
      t.string :postal_code
      t.string :city
      t.string :country
      t.string :google_maps_url

      # Social
      t.string :facebook_url
      t.string :instagram_url
      t.string :linkedin_url
      t.string :youtube_url

      # Theme
      t.string :primary_color, default: "#2563eb"
      t.string :secondary_color, default: "#1e40af"
      t.string :background_color, default: "#ffffff"
      t.string :text_color, default: "#1f2937"
      t.string :button_color, default: "#2563eb"
      t.string :button_text_color, default: "#ffffff"
      t.string :navbar_background_color, default: "#ffffff"
      t.string :footer_background_color, default: "#111827"

      # SEO
      t.string :site_title
      t.text :meta_description
      t.text :meta_keywords
      t.string :og_title
      t.text :og_description

      # Visibility
      t.boolean :show_blog, default: true, null: false
      t.boolean :show_about, default: true, null: false
      t.boolean :show_services, default: true, null: false
      t.boolean :show_contact, default: true, null: false

      # About & Services content
      t.text :about_content
      t.text :services_content

      t.timestamps
    end
  end
end
