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

ActiveRecord::Schema[8.0].define(version: 2025_06_19_065047) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "bulk_discount_rules", force: :cascade do |t|
    t.integer "min_quantity"
    t.integer "discount_price_cents"
    t.string "discount_price_currency"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "carts", force: :cascade do |t|
    t.integer "total_cost_cents", default: 0
    t.string "total_cost_currency", default: "USD"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "line_items", force: :cascade do |t|
    t.bigint "cart_id", null: false
    t.bigint "product_id", null: false
    t.integer "quantity", default: 1
    t.integer "unit_cost_cents"
    t.integer "total_cost_cents", default: 0
    t.integer "discount_cost_cents", default: 0
    t.string "unit_cost_currency", default: "USD"
    t.string "total_cost_currency", default: "USD"
    t.string "discount_cost_currency", default: "USD"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cart_id"], name: "index_line_items_on_cart_id"
    t.index ["product_id"], name: "index_line_items_on_product_id"
  end

  create_table "prices", force: :cascade do |t|
    t.bigint "product_id", null: false
    t.integer "amount_cents", null: false
    t.string "amount_currency", default: "USD"
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_prices_on_product_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "name", null: false
    t.string "code", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_products_on_code", unique: true
  end

  create_table "promotions", force: :cascade do |t|
    t.bigint "product_id", null: false
    t.string "rule_type", null: false
    t.bigint "rule_id"
    t.string "code", null: false
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "active", default: false
    t.index ["active"], name: "index_promotions_on_active"
    t.index ["code"], name: "index_promotions_on_code", unique: true
    t.index ["product_id"], name: "index_promotions_on_product_id"
    t.index ["rule_type", "rule_id"], name: "index_promotions_on_rule_type_and_rule_id"
  end

  add_foreign_key "line_items", "carts"
  add_foreign_key "line_items", "products"
  add_foreign_key "prices", "products"
  add_foreign_key "promotions", "products"
end
