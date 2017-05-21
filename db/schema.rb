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

ActiveRecord::Schema.define(version: 20170521141751) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "interests", force: :cascade do |t|
    t.string "interest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["interest"], name: "index_interests_on_interest", unique: true
  end

  create_table "interests_organizations", id: false, force: :cascade do |t|
    t.bigint "organization_id", null: false
    t.bigint "interest_id", null: false
    t.index ["interest_id"], name: "index_interests_organizations_on_interest_id"
    t.index ["organization_id"], name: "index_interests_organizations_on_organization_id"
  end

  create_table "interests_users", id: false, force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "interest_id", null: false
    t.index ["interest_id"], name: "index_interests_users_on_interest_id"
    t.index ["user_id"], name: "index_interests_users_on_user_id"
  end

  create_table "organization_users", force: :cascade do |t|
    t.integer "organization_id", null: false
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["organization_id", "user_id"], name: "index_organization_users_on_organization_id_and_user_id", unique: true
    t.index ["organization_id"], name: "index_organization_users_on_organization_id"
    t.index ["user_id"], name: "index_organization_users_on_user_id"
  end

  create_table "organizations", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.string "address", null: false
    t.string "city", null: false
    t.string "state", null: false
    t.string "zipcode", null: false
    t.string "website_url"
    t.float "latitude"
    t.float "longitude"
  end

  create_table "organizations_skills", id: false, force: :cascade do |t|
    t.bigint "organization_id", null: false
    t.bigint "skill_id", null: false
    t.index ["organization_id"], name: "index_organizations_skills_on_organization_id"
    t.index ["skill_id"], name: "index_organizations_skills_on_skill_id"
  end

  create_table "projects", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.text "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "skills", force: :cascade do |t|
    t.string "skill", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["skill"], name: "index_skills_on_skill", unique: true
  end

  create_table "skills_users", id: false, force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "skill_id", null: false
    t.index ["skill_id"], name: "index_skills_users_on_skill_id"
    t.index ["user_id"], name: "index_skills_users_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "address", null: false
    t.string "city", null: false
    t.string "state", null: false
    t.string "zipcode", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "latitude"
    t.float "longitude"
    t.boolean "private", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
