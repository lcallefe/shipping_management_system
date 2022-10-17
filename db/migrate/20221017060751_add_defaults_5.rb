class AddDefaults5 < ActiveRecord::Migration[7.0]
  def change
    drop_table :expressa_delivery_time_distances
    drop_table :expressa_price_distances
    drop_table :expressa_price_weights
    drop_table :sedex_delivery_time_distances
    drop_table :sedex_price_distances
    drop_table :sedex_price_weights
    drop_table :sedex_dez_delivery_time_distances
    drop_table :sedex_dez_price_distances
    drop_table :sedex_dez_price_weights

    create_table "expressa_delivery_time_distances", force: :cascade do |t|
      t.integer "min_distance"
      t.integer "max_distance"
      t.integer "delivery_time"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.integer "expressa_id", default: 1
      t.index ["expressa_id"], name: "index_expressa_delivery_time_distances_on_expressa_id"
    end

    create_table "expressa_price_distances", force: :cascade do |t|
      t.integer "min_distance"
      t.integer "max_distance"
      t.integer "price"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.integer "expressa_id", default: 1
      t.index ["expressa_id"], name: "index_expressa_price_distances_on_expressa_id"
    end

    create_table "expressa_price_weights", force: :cascade do |t|
      t.integer "min_weight"
      t.integer "max_weight"
      t.float "price"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.integer "expressa_id", default: 1
      t.index ["expressa_id"], name: "index_expressa_price_weights_on_expressa_id"
    end

    create_table "sedex_delivery_time_distances", force: :cascade do |t|
      t.integer "min_distance"
      t.integer "max_distance"
      t.integer "delivery_time"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.integer "sedex_id", default: 1
      t.index ["sedex_id"], name: "index_sedex_delivery_time_distances_on_sedex_id"
    end

    create_table "sedex_dez_delivery_time_distances", force: :cascade do |t|
      t.integer "min_distance"
      t.integer "max_distance"
      t.integer "delivery_time"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.integer "sedex_dez_id", default: 1
      t.index ["sedex_dez_id"], name: "index_sedex_dez_delivery_time_distances_on_sedex_dez_id"
    end

    create_table "sedex_dez_price_distances", force: :cascade do |t|
      t.integer "min_distance"
      t.integer "max_distance"
      t.integer "price"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.integer "sedex_dez_id", default: 1
      t.index ["sedex_dez_id"], name: "index_sedex_dez_price_distances_on_sedex_dez_id"
    end

    create_table "sedex_dez_price_weights", force: :cascade do |t|
      t.integer "min_weight"
      t.integer "max_weight"
      t.float "price"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.integer "sedex_dez_id", default: 1
      t.index ["sedex_dez_id"], name: "index_sedex_dez_price_weights_on_sedex_dez_id"
    end

    create_table "sedex_price_distances", force: :cascade do |t|
      t.integer "min_distance"
      t.integer "max_distance"
      t.integer "price"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.integer "sedex_id", default: 1
      t.index ["sedex_id"], name: "index_sedex_price_distances_on_sedex_id"
    end

    create_table "sedex_price_weights", force: :cascade do |t|
      t.integer "min_weight"
      t.integer "max_weight"
      t.float "price"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.integer "sedex_id", default: 1
      t.index ["sedex_id"], name: "index_sedex_price_weights_on_sedex_id"
    end

  end
end
