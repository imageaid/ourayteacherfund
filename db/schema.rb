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

ActiveRecord::Schema[7.1].define(version: 2023_10_11_162308) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "action_text_rich_texts", force: :cascade do |t|
    t.string "name", null: false
    t.text "body"
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["record_type", "record_id", "name"], name: "index_action_text_rich_texts_uniqueness", unique: true
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "donations", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.decimal "amount", default: "0.0"
    t.boolean "recurring", default: false
    t.boolean "thanked", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "received_on"
    t.index ["user_id"], name: "index_donations_on_user_id"
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_type", "sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_type_and_sluggable_id"
  end

  create_table "grant_requests", force: :cascade do |t|
    t.bigint "grant_id", null: false
    t.bigint "user_id", null: false
    t.string "school_year"
    t.decimal "amount_requested"
    t.jsonb "responses", default: {}
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "purpose", default: 0
    t.string "slug", null: false
    t.text "other_data"
    t.index ["grant_id"], name: "index_grant_requests_on_grant_id"
    t.index ["user_id"], name: "index_grant_requests_on_user_id"
  end

  create_table "grant_reviews", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "grant_request_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["grant_request_id"], name: "index_grant_reviews_on_grant_request_id"
    t.index ["user_id"], name: "index_grant_reviews_on_user_id"
  end

  create_table "grants", force: :cascade do |t|
    t.string "name"
    t.text "details"
    t.boolean "active", default: true
    t.jsonb "questions", default: []
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["active"], name: "index_grants_on_active", unique: true
    t.index ["name"], name: "index_grants_on_name", unique: true
  end

  create_table "pages", force: :cascade do |t|
    t.string "title"
    t.string "keywords"
    t.string "link_label"
    t.string "slug"
    t.boolean "welcome_content", default: false
    t.boolean "navigation", default: false
    t.integer "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["link_label"], name: "index_pages_on_link_label", unique: true
    t.index ["slug"], name: "index_pages_on_slug", unique: true
    t.index ["title"], name: "index_pages_on_title", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.virtual "name", type: :string, as: "(((first_name)::text || ' '::text) || (last_name)::text)", stored: true
    t.string "email", null: false
    t.string "type", default: "User", null: false
    t.string "slug", null: false
    t.integer "role", default: 0
    t.boolean "active", default: true
    t.jsonb "meta", default: {}
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "crypted_password"
    t.string "salt"
    t.string "remember_me_token"
    t.datetime "remember_me_token_expires_at"
    t.string "reset_password_token"
    t.datetime "reset_password_token_expires_at"
    t.datetime "reset_password_email_sent_at"
    t.integer "access_count_to_reset_password_page", default: 0
    t.string "magic_login_token"
    t.datetime "magic_login_token_expires_at"
    t.datetime "magic_login_email_sent_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["magic_login_token"], name: "index_users_on_magic_login_token"
    t.index ["remember_me_token"], name: "index_users_on_remember_me_token"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token"
    t.index ["slug"], name: "index_users_on_slug", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "donations", "users"
  add_foreign_key "grant_requests", "grants"
  add_foreign_key "grant_requests", "users"
  add_foreign_key "grant_reviews", "grant_requests"
  add_foreign_key "grant_reviews", "users"
end
