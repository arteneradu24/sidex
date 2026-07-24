# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.1].define(version: 2025_07_24_090004) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "action_text_rich_texts", force: :cascade do |t|
    t.text "body"
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.bigint "record_id", null: false
    t.string "record_type", null: false
    t.datetime "updated_at", null: false
    t.index ["record_type", "record_id", "name"], name: "index_action_text_rich_texts_uniqueness", unique: true
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.bigint "record_id", null: false
    t.string "record_type", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.string "content_type"
    t.datetime "created_at", null: false
    t.string "filename", null: false
    t.string "key", null: false
    t.text "metadata"
    t.string "service_name", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "contact_messages", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email", null: false
    t.text "message", null: false
    t.string "name", null: false
    t.string "phone"
    t.integer "status", default: 0, null: false
    t.string "subject"
    t.datetime "updated_at", null: false
    t.index ["status"], name: "index_contact_messages_on_status"
  end

  create_table "posts", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.text "excerpt"
    t.boolean "published", default: false, null: false
    t.datetime "published_at"
    t.string "slug", null: false
    t.string "title", null: false
    t.datetime "updated_at", null: false
    t.index ["published"], name: "index_posts_on_published"
    t.index ["published_at"], name: "index_posts_on_published_at"
    t.index ["slug"], name: "index_posts_on_slug", unique: true
  end

  create_table "site_settings", force: :cascade do |t|
    t.text "about_content"
    t.string "about_label", default: "About"
    t.string "background_color", default: "#ffffff"
    t.string "blog_label", default: "Blog"
    t.string "button_color", default: "#2563eb"
    t.string "button_text_color", default: "#ffffff"
    t.string "city"
    t.string "company_name"
    t.string "company_tagline"
    t.string "contact_label", default: "Contact"
    t.string "country"
    t.datetime "created_at", null: false
    t.string "email"
    t.string "facebook_url"
    t.string "footer_background_color", default: "#111827"
    t.string "google_maps_url"
    t.string "hero_button_text"
    t.string "hero_button_url"
    t.text "hero_subtitle"
    t.string "hero_title"
    t.string "home_label", default: "Home"
    t.string "instagram_url"
    t.string "linkedin_url"
    t.text "meta_description"
    t.text "meta_keywords"
    t.string "navbar_background_color", default: "#ffffff"
    t.text "og_description"
    t.string "og_title"
    t.string "phone"
    t.string "postal_code"
    t.string "primary_color", default: "#2563eb"
    t.string "secondary_color", default: "#1e40af"
    t.text "services_content"
    t.string "services_label", default: "Services"
    t.boolean "show_about", default: true, null: false
    t.boolean "show_blog", default: true, null: false
    t.boolean "show_contact", default: true, null: false
    t.boolean "show_services", default: true, null: false
    t.string "site_title"
    t.string "street"
    t.string "text_color", default: "#1f2937"
    t.datetime "updated_at", null: false
    t.string "website"
    t.string "youtube_url"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.datetime "remember_created_at"
    t.datetime "reset_password_sent_at"
    t.string "reset_password_token"
    t.integer "role", default: 0, null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end
end
