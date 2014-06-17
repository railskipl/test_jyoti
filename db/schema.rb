# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20140617064834) do

  create_table "advice_contacts", force: true do |t|
    t.string   "email"
    t.text     "praise"
    t.text     "criticism"
    t.text     "helpful_tips"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "circles", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contacts", force: true do |t|
    t.string   "email"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "countries", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "feedbacks", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "friends", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "individuals", force: true do |t|
    t.string   "title"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "pic_file_name"
    t.string   "pic_content_type"
    t.integer  "pic_file_size"
    t.datetime "pic_updated_at"
  end

  create_table "influences", force: true do |t|
    t.string   "your_influence"
    t.string   "influence_on_your"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email"
    t.integer  "user_id"
  end

  create_table "invitations", force: true do |t|
    t.integer  "sender_id"
    t.string   "recipient_email"
    t.string   "token"
    t.datetime "sent_at"
    t.string   "new"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "mailers", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "organizations", force: true do |t|
    t.string   "title"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "img_file_name"
    t.string   "img_content_type"
    t.integer  "img_file_size"
    t.datetime "img_updated_at"
  end

  create_table "pages", force: true do |t|
    t.string   "title"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.boolean  "status",             default: false
  end

  create_table "paste_users", force: true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "circle_id"
  end

  create_table "power_groups", force: true do |t|
    t.integer  "user_id"
    t.string   "email"
    t.string   "your_influence"
    t.string   "influence_on_your"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "influence_id"
  end

  create_table "user_invitations", force: true do |t|
    t.integer  "paste_user_id"
    t.string   "email"
    t.boolean  "invite_for_feedback"
    t.boolean  "invite_for_curiosity"
    t.string   "opinion_value"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "circle_id"
  end

  create_table "users", force: true do |t|
    t.string   "email",                     default: "", null: false
    t.string   "password",                  default: "", null: false
    t.string   "encrypted_password",        default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",             default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "provider"
    t.string   "uid"
    t.string   "oauth_token"
    t.datetime "oauth_expires_at"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_admin"
    t.integer  "invitation_id"
    t.integer  "invitation_limit"
    t.string   "remember_token"
    t.datetime "remember_token_expires_at"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "sex"
    t.date     "birthday"
    t.string   "location"
    t.string   "organization"
    t.string   "industry"
    t.string   "secondary_email"
    t.string   "zip"
    t.string   "orgsize"
    t.boolean  "guest"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
