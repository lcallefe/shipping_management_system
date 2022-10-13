class Recreating < ActiveRecord::Migration[7.0]
  def change
    create_table "expressas", force: :cascade do |t|
      t.string "name"
      t.integer "flat_fee"
      t.integer "status", default: 1
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.integer "work_order_id"
      t.index ["work_order_id"], name: "index_expressas_on_work_order_id"
    end
  
    create_table "first_delivery_time_distances", force: :cascade do |t|
      t.integer "min_distance"
      t.integer "max_distance"
      t.integer "delivery_time"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.integer "sedex_dez_id"
      t.index ["sedex_dez_id"], name: "index_first_delivery_time_distances_on_sedex_dez_id"
    end
  
    create_table "first_price_distances", force: :cascade do |t|
      t.integer "min_distance"
      t.integer "max_distance"
      t.integer "price"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.integer "sedex_dez_id"
      t.index ["sedex_dez_id"], name: "index_first_price_distances_on_sedex_dez_id"
    end
  
    create_table "first_price_weights", force: :cascade do |t|
      t.integer "min_weight"
      t.integer "max_weight"
      t.float "price"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.integer "sedex_dez_id"
      t.index ["sedex_dez_id"], name: "index_first_price_weights_on_sedex_dez_id"
    end
  
    create_table "second_delivery_time_distances", force: :cascade do |t|
      t.integer "min_distance"
      t.integer "max_distance"
      t.integer "delivery_time"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.integer "sedex_id"
      t.index ["sedex_id"], name: "index_second_delivery_time_distances_on_sedex_id"
    end
  
    create_table "second_price_distances", force: :cascade do |t|
      t.integer "min_distance"
      t.integer "max_distance"
      t.integer "price"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.integer "sedex_id"
      t.index ["sedex_id"], name: "index_second_price_distances_on_sedex_id"
    end
  
    create_table "second_price_weights", force: :cascade do |t|
      t.integer "min_weight"
      t.integer "max_weight"
      t.float "price"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.integer "sedex_id"
      t.index ["sedex_id"], name: "index_second_price_weights_on_sedex_id"
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
  
    create_table "sedexes", force: :cascade do |t|
      t.string "name"
      t.integer "flat_fee"
      t.integer "status", default: 1
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.integer "work_order_id"
      t.index ["work_order_id"], name: "index_sedexes_on_work_order_id"
    end
  
    create_table "third_delivery_time_distances", force: :cascade do |t|
      t.integer "min_distance"
      t.integer "max_distance"
      t.integer "delivery_time"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.integer "expressa_id"
      t.index ["expressa_id"], name: "index_third_delivery_time_distances_on_expressa_id"
    end
  
    create_table "third_price_distances", force: :cascade do |t|
      t.integer "min_distance"
      t.integer "max_distance"
      t.integer "price"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.integer "expressa_id"
      t.index ["expressa_id"], name: "index_third_price_distances_on_expressa_id"
    end
  
    create_table "third_price_weights", force: :cascade do |t|
      t.integer "min_weight"
      t.integer "max_weight"
      t.float "price"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.integer "expressa_id"
      t.index ["expressa_id"], name: "index_third_price_weights_on_expressa_id"
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
end
