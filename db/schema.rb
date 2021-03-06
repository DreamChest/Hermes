# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20180723202353) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "articles", force: :cascade do |t|
    t.bigint "source_id"
    t.string "title"
    t.datetime "date"
    t.string "url"
    t.boolean "favorite", default: false
    t.boolean "read", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["source_id"], name: "index_articles_on_source_id"
  end

  create_table "contents", force: :cascade do |t|
    t.bigint "article_id"
    t.text "html"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["article_id"], name: "index_contents_on_article_id"
  end

  create_table "friendly_id_slugs", id: :serial, force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id"
    t.index ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type"
  end

  create_table "sources", force: :cascade do |t|
    t.bigint "user_id"
    t.string "name"
    t.string "url"
    t.string "favicon_url"
    t.string "favicon_path"
    t.datetime "last_update", default: "1970-01-01 00:00:00"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_sources_on_user_id"
  end

  create_table "sources_tags", id: false, force: :cascade do |t|
    t.bigint "source_id", null: false
    t.bigint "tag_id", null: false
    t.index ["source_id", "tag_id"], name: "index_sources_tags_on_source_id_and_tag_id"
    t.index ["tag_id", "source_id"], name: "index_sources_tags_on_tag_id_and_source_id"
  end

  create_table "tags", force: :cascade do |t|
    t.bigint "user_id"
    t.string "name"
    t.string "color", default: "#ffffff"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_tags_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
