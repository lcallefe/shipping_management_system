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

ActiveRecord::Schema[7.0].define(version: 2022_10_13_080750) do
  create_table "expressa_delivery_time_distances", force: :cascade do |t|
    t.integer "min_distance"
    t.integer "max_distance"
    t.integer "delivery_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "expressa_id"
    t.index ["expressa_id"], name: "index_expressa_delivery_time_distances_on_expressa_id"
  end

  create_table "expressa_price_distances", force: :cascade do |t|
    t.integer "min_distance"
    t.integer "max_distance"
    t.integer "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "expressa_id"
    t.index ["expressa_id"], name: "index_expressa_price_distances_on_expressa_id"
  end

  create_table "expressa_price_weights", force: :cascade do |t|
    t.integer "min_weight"
    t.integer "max_weight"
    t.float "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "expressa_id"
    t.index ["expressa_id"], name: "index_expressa_price_weights_on_expressa_id"
  end

  create_table "expressas", force: :cascade do |t|
    t.string "name"
    t.integer "flat_fee"
    t.integer "status", default: 1
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "work_order_id"
    t.index ["work_order_id"], name: "index_expressas_on_work_order_id"
  end

  create_table "sedex_delivery_time_distances", force: :cascade do |t|
    t.integer "min_distance"
    t.integer "max_distance"
    t.integer "delivery_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "sedex_id"
    t.index ["sedex_id"], name: "index_sedex_delivery_time_distances_on_sedex_id"
  end

  create_table "sedex_dez_delivery_time_distances", force: :cascade do |t|
    t.integer "min_distance"
    t.integer "max_distance"
    t.integer "delivery_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "sedex_dez_id"
    t.index ["sedex_dez_id"], name: "index_sedex_dez_delivery_time_distances_on_sedex_dez_id"
  end

  create_table "sedex_dez_price_distances", force: :cascade do |t|
    t.integer "min_distance"
    t.integer "max_distance"
    t.integer "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "sedex_dez_id"
    t.index ["sedex_dez_id"], name: "index_sedex_dez_price_distances_on_sedex_dez_id"
  end

  create_table "sedex_dez_price_weights", force: :cascade do |t|
    t.integer "min_weight"
    t.integer "max_weight"
    t.float "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "sedex_dez_id"
    t.index ["sedex_dez_id"], name: "index_sedex_dez_price_weights_on_sedex_dez_id"
  end

  create_table "sedex_dezs", force: :cascade do |t|
    t.string "name"
    t.integer "flat_fee"
    t.integer "status", default: 1
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "work_order_id"
    t.index ["work_order_id"], name: "index_sedex_dezs_on_work_order_id"
  end

  create_table "sedex_price_distances", force: :cascade do |t|
    t.integer "min_distance"
    t.integer "max_distance"
    t.integer "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "sedex_id"
    t.index ["sedex_id"], name: "index_sedex_price_distances_on_sedex_id"
  end

  create_table "sedex_price_weights", force: :cascade do |t|
    t.integer "min_weight"
    t.integer "max_weight"
    t.float "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "sedex_id"
    t.index ["sedex_id"], name: "index_sedex_price_weights_on_sedex_id"
  end

  create_table "sedexes", force: :cascade do |t|
    t.string "name"
    t.integer "flat_fee"
    t.integer "status", default: 1
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "work_order_id"
    t.index ["work_order_id"], name: "index_sedexes_on_work_order_id"
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
    t.string "brand_name"
    t.string "fabrication_year"
    t.integer "full_capacity"
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "sedex_dez_id"
    t.integer "sedex_id"
    t.integer "expressa_id"
    t.string "license_plate"
    t.string "model"
    t.integer "work_order_id"
    t.index ["expressa_id"], name: "index_vehicles_on_expressa_id"
    t.index ["sedex_dez_id"], name: "index_vehicles_on_sedex_dez_id"
    t.index ["sedex_id"], name: "index_vehicles_on_sedex_id"
    t.index ["work_order_id"], name: "index_vehicles_on_work_order_id"
  end

  create_table "work_orders", force: :cascade do |t|
    t.string "street"
    t.string "city"
    t.string "state"
    t.string "number"
    t.string "customer_name"
    t.string "customer_cpf"
    t.string "customer_phone_numer"
    t.integer "total_price"
    t.string "product_name"
    t.integer "product_weight"
    t.string "sku"
    t.date "departure_date"
    t.date "shipping_expected_date"
    t.date "shipping_date"
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "warehouse_street"
    t.string "warehouse_city"
    t.string "warehouse_state"
    t.string "warehouse_number"
    t.integer "distance"
    t.string "code"
    t.string "shipping_method"
    t.string "delay_reason"
  end

  add_foreign_key "vehicles", "work_orders"
end
