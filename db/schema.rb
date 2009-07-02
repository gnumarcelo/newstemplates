# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20090605130449) do

  create_table "articles", :force => true do |t|
    t.string   "title"
    t.text     "content"
    t.integer  "author_id",  :limit => 11
    t.integer  "edition_id", :limit => 11
    t.integer  "position",   :limit => 11
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "highlight"
  end

  create_table "authors", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "inactive"
  end

  create_table "editions", :force => true do |t|
    t.date     "published_on"
    t.integer  "newsletter_id",     :limit => 11
    t.string   "state"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "parent_edition_id", :limit => 11
  end

  create_table "lists", :force => true do |t|
    t.string "name"
    t.string "cm_list_id"
  end

  create_table "lists_newsletters", :id => false, :force => true do |t|
    t.integer "list_id",       :limit => 11
    t.integer "newsletter_id", :limit => 11
  end

  create_table "newsletters", :force => true do |t|
    t.string   "title"
    t.string   "template"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "assets"
    t.string   "url"
    t.string   "from_email"
    t.string   "reply_to_email"
    t.string   "from_name"
    t.string   "short_name"
    t.string   "email_subject"
    t.boolean  "send_automatically"
    t.string   "confirmation_email"
  end

end
