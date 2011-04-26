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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110308214821) do

  create_table "entries", :force => true do |t|
    t.integer  "till_id",                                        :null => false
    t.string   "title"
    t.string   "description"
    t.datetime "time",        :default => '2011-03-25 08:10:19', :null => false
    t.integer  "amount"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "items", :force => true do |t|
    t.string   "title",                          :null => false
    t.string   "description"
    t.string   "sku"
    t.integer  "price",       :default => 0,     :null => false
    t.boolean  "taxable",     :default => true,  :null => false
    t.boolean  "locked",      :default => false, :null => false
    t.boolean  "active",      :default => false, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "lines", :force => true do |t|
    t.integer  "transaction_id"
    t.integer  "item_id"
    t.integer  "quantity",                         :null => false
    t.integer  "price",                            :null => false
    t.boolean  "taxable",        :default => true, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "payments", :force => true do |t|
    t.integer  "transaction_id",                :null => false
    t.string   "form",                          :null => false
    t.integer  "amount",         :default => 0, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "properties", :force => true do |t|
    t.integer  "item_id",    :null => false
    t.string   "key",        :null => false
    t.string   "value",      :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tills", :force => true do |t|
    t.string   "title"
    t.string   "description"
    t.integer  "minimum_transfer"
    t.integer  "minimum_balance"
    t.boolean  "retainable",       :default => true, :null => false
    t.boolean  "active",           :default => true, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tills_users", :id => false, :force => true do |t|
    t.integer "till_id"
    t.integer "user_id"
  end

  create_table "transactions", :force => true do |t|
    t.integer  "till_id"
    t.integer  "customer_id"
    t.integer  "user_id"
    t.decimal  "tax_rate",    :precision => 10, :scale => 2, :default => 0.07,  :null => false
    t.boolean  "complete",                                   :default => true,  :null => false
    t.boolean  "locked",                                     :default => false, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
