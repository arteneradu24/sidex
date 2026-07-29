# frozen_string_literal: true

class AddMainSectionToSitePages < ActiveRecord::Migration[8.1]
  def change
    change_table :site_pages, bulk: true do |t|
      t.string :main_title
      t.text :main_subtitle
      t.string :cta_title
      t.text :cta_subtitle
      t.string :cta_button_text
      t.string :cta_button_url
      t.boolean :show_cta, null: false, default: true
    end
  end
end
