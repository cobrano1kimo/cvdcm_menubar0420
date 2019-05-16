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

ActiveRecord::Schema.define(version: 20190509022638) do

  create_table "CDF", primary_key: "CDF00", id: :char, limit: 3, default: nil, force: :cascade do |t|
    t.varchar "CDF01", limit: 120
    t.varchar "CRE_USERID", limit: 10
    t.char "CRE_DTIME", limit: 14
    t.varchar "UPD_USERID", limit: 10
    t.char "UPD_DTIME", limit: 14
  end

  create_table "articles", force: :cascade do |t|
    t.string "title"
    t.text "text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "large_classifications", primary_key: "large_classification_id", id: :string, limit: 3, default: nil, force: :cascade do |t|
    t.string "description", limit: 120
    t.string "created_staff", limit: 20
    t.string "updated_staff", limit: 20
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "medium_classifications", primary_key: ["large_classification_id", "medium_classification_id"], force: :cascade do |t|
    t.string "large_classification_id", limit: 3, null: false
    t.string "medium_classification_id", limit: 3, null: false
    t.string "description", limit: 120
    t.float "value_1"
    t.float "value_2"
    t.string "remark", limit: 240
    t.string "created_staff", limit: 20
    t.string "updated_staff", limit: 20
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "menubars", primary_key: "menu_id", id: :string, limit: 8, default: "", force: :cascade do |t|
    t.string "menu_name", limit: 40, default: ""
    t.string "parent_menu_id", limit: 6, default: ""
    t.integer "menu_sn", default: 0
    t.string "program_id", default: ""
    t.string "program_url", default: ""
    t.integer "lock_version", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "small_classifications", primary_key: ["large_classification_id", "medium_classification_id", "small_classification_id"], force: :cascade do |t|
    t.string "large_classification_id", limit: 3, null: false
    t.string "medium_classification_id", limit: 3, null: false
    t.string "small_classification_id", limit: 3, null: false
    t.string "description", limit: 120
    t.string "remark", limit: 240
    t.string "created_staff", limit: 20
    t.string "updated_staff", limit: 20
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "login", default: "", null: false
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["login"], name: "index_users_on_login", unique: true
  end

  add_foreign_key "medium_classifications", "large_classifications", primary_key: "large_classification_id", name: "fk_medium_classification"
  add_foreign_key "small_classifications", "medium_classifications", column: "large_classification_id", primary_key: "large_classification_id", name: "fk_small_classification"
  add_foreign_key "small_classifications", "medium_classifications", primary_key: "medium_classification_id", name: "fk_small_classification"
end
