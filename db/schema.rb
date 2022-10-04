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

ActiveRecord::Schema[7.0].define(version: 2022_10_03_235853) do
  create_table "addresses", force: :cascade do |t|
    t.string "street"
    t.string "number"
    t.string "city"
    t.string "state"
    t.string "address_complement"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "customer_id", null: false
    t.integer "order_id", null: false
    t.index ["customer_id"], name: "index_addresses_on_customer_id"
    t.index ["order_id"], name: "index_addresses_on_order_id"
  end

  create_table "customers", force: :cascade do |t|
    t.string "cpf"
    t.string "name"
    t.string "email"
    t.string "phone_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "orders", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "distance"
    t.date "departure_date"
    t.date "shipping_expected_date"
    t.date "shipping_date"
    t.integer "total_price"
    t.integer "status"
    t.string "sku"
    t.string "product_name"
    t.integer "product_weight"
    t.integer "customer_id", null: false
    t.index ["customer_id"], name: "index_orders_on_customer_id"
  end

  create_table "shipping_methods", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "min_distance"
    t.string "max_distance"
    t.string "min_weight"
    t.string "max_weight"
    t.integer "flat_fee"
    t.string "weight_fee"
    t.string "distance_fee"
    t.integer "status", default: 1
    t.integer "order_id", null: false
    t.index ["order_id"], name: "index_shipping_methods_on_order_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "admin", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "vehicles", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "license_plate"
    t.string "name"
    t.string "brand_name"
    t.string "model"
    t.string "fabrication_year"
    t.integer "full_capacity"
    t.integer "status", default: 1
    t.integer "shipping_method_id"
    t.index ["shipping_method_id"], name: "index_vehicles_on_shipping_method_id"
  end

  add_foreign_key "addresses", "customers"
  add_foreign_key "addresses", "orders"
  add_foreign_key "orders", "customers"
  add_foreign_key "shipping_methods", "orders"
  add_foreign_key "vehicles", "shipping_methods"
end
