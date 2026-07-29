# frozen_string_literal: true

class CreateSitePages < ActiveRecord::Migration[8.1]
  def change
    create_table :site_pages do |t|
      t.string :label, null: false
      t.string :slug, null: false
      t.string :hero_title
      t.text :hero_subtitle
      t.string :hero_button_text
      t.string :hero_button_url
      t.integer :position, null: false, default: 0
      t.boolean :published, null: false, default: true
      t.boolean :show_in_nav, null: false, default: true

      t.timestamps
    end

    add_index :site_pages, :slug, unique: true
    add_index :site_pages, :position
    add_index :site_pages, :published
  end
end
