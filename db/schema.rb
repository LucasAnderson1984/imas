# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_11_14_021849) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bill_of_materials", force: :cascade do |t|
    t.string "code", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["code"], name: "index_bill_of_materials_on_code", unique: true
  end

  create_table "customers", force: :cascade do |t|
    t.string "name", null: false
    t.string "address"
    t.string "city"
    t.string "state", limit: 2
    t.string "zip", limit: 5
    t.string "country", limit: 2
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_customers_on_name", unique: true
  end

  create_table "items", force: :cascade do |t|
    t.string "item_number", null: false
    t.string "item_description"
    t.integer "is_active", default: 1, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "unit_of_measure_id", null: false
    t.bigint "bill_of_material_id"
    t.index ["bill_of_material_id"], name: "index_items_on_bill_of_material_id"
    t.index ["item_number"], name: "index_items_on_item_number", unique: true
    t.index ["unit_of_measure_id"], name: "index_items_on_unit_of_measure_id"
  end

  create_table "sales", force: :cascade do |t|
    t.bigint "customer_id"
    t.bigint "item_id"
    t.bigint "unit_of_measure_id"
    t.date "sales_date"
    t.integer "sales_quantity"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["customer_id"], name: "index_sales_on_customer_id"
    t.index ["item_id"], name: "index_sales_on_item_id"
    t.index ["unit_of_measure_id"], name: "index_sales_on_unit_of_measure_id"
  end

  create_table "unit_of_measures", force: :cascade do |t|
    t.string "code", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["code"], name: "index_unit_of_measures_on_code", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.uuid "uuid", null: false
    t.string "name", null: false
    t.integer "is_active", default: 1, null: false
    t.string "email", null: false
    t.string "encrypted_password"
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.string "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer "invitation_limit"
    t.string "invited_by_type"
    t.bigint "invited_by_id"
    t.integer "invitations_count", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["invitation_token"], name: "index_users_on_invitation_token", unique: true
    t.index ["invitations_count"], name: "index_users_on_invitations_count"
    t.index ["invited_by_id"], name: "index_users_on_invited_by_id"
    t.index ["invited_by_type", "invited_by_id"], name: "index_users_on_invited_by_type_and_invited_by_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["uuid"], name: "index_users_on_uuid", unique: true
  end

end
