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

ActiveRecord::Schema.define(version: 20140728093326) do

  create_table "access_reputation_tips", force: true do |t|
    t.integer  "user_id"
    t.integer  "give_feedback",          default: 0
    t.integer  "vote_on_tips",           default: 0
    t.integer  "invite_other",           default: 0
    t.integer  "give_ratings",           default: 0
    t.integer  "give_selfimage",         default: 0
    t.integer  "got_feedback",           default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "start_date"
    t.string   "end_date"
    t.boolean  "intial_reaction_view",   default: false
    t.boolean  "intial_reputation_view", default: false
  end

  create_table "advice_contacts", force: true do |t|
    t.string   "email"
    t.text     "praise"
    t.text     "criticism"
    t.text     "helpful_tips"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "avg_ratings", force: true do |t|
    t.float    "trustworthy"
    t.float    "kind_helpful"
    t.float    "potential"
    t.float    "presentable"
    t.float    "perform_well"
    t.float    "emotianally_mature"
    t.float    "friendly_social"
    t.float    "overall"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
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

  create_table "contactus", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "subject"
    t.text     "message"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "countries", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "criticisms", force: true do |t|
    t.text     "criticism_comment"
    t.integer  "provider_user_id"
    t.string   "email"
    t.integer  "tip_accept",        default: 0
    t.integer  "tip_reject",        default: 0
    t.text     "feedback"
    t.string   "comment_quality"
    t.integer  "tip_viewed",        default: 0
    t.integer  "tip_prediction",    default: 0
    t.string   "typee"
    t.string   "circle_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "emails", force: true do |t|
    t.string   "email"
    t.integer  "user_id"
    t.string   "token"
    t.boolean  "verified"
    t.boolean  "merged",     default: false
    t.boolean  "primary"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "factors", force: true do |t|
    t.string   "custom_factor"
    t.integer  "circle_id"
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

  create_table "generals", force: true do |t|
    t.text     "general_comment"
    t.integer  "provider_user_id"
    t.string   "email"
    t.integer  "tip_accept",       default: 0
    t.integer  "tip_reject",       default: 0
    t.text     "feedback"
    t.string   "comment_quality"
    t.integer  "tip_viewed",       default: 0
    t.integer  "tip_prediction",   default: 0
    t.string   "typee"
    t.string   "circle_name"
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
    t.integer  "relationship_id"
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

  create_table "palpal_payments", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "paste_users", force: true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "circle_id"
  end

  create_table "paypal_payments", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "plans", force: true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "email"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "price"
  end

  create_table "power_groups", force: true do |t|
    t.integer  "user_id"
    t.string   "email"
    t.string   "your_influence"
    t.string   "influence_on_your"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "influence_id"
    t.integer  "circle_id"
    t.integer  "know_how_for_long_year"
    t.integer  "know_how_for_long_month"
    t.string   "how_well_you_know_the_person"
    t.text     "praise_tips"
    t.text     "criticism_tips"
    t.text     "helpful_tips"
    t.string   "power_group_eamil"
    t.string   "custom_factor"
    t.integer  "relationship_id"
    t.string   "circle_name"
  end

  create_table "praises", force: true do |t|
    t.text     "praise_comment"
    t.integer  "provider_user_id"
    t.string   "email"
    t.integer  "tip_accept",       default: 0
    t.integer  "tip_reject",       default: 0
    t.text     "feedback"
    t.string   "comment_quality"
    t.integer  "tip_viewed",       default: 0
    t.integer  "tip_prediction",   default: 0
    t.string   "typee"
    t.string   "circle_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ratingothers", force: true do |t|
    t.string   "email"
    t.string   "user_id"
    t.integer  "friend_id"
    t.integer  "trustworthy"
    t.integer  "kind_helpful"
    t.integer  "potential"
    t.integer  "perform_well"
    t.integer  "presentable"
    t.integer  "emotianally_mature"
    t.integer  "friendly_social"
    t.integer  "rate_count"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "anonymous_user",     default: false
  end

  create_table "ratings", force: true do |t|
    t.integer  "user_id"
    t.integer  "friend_id"
    t.integer  "trustworthy"
    t.integer  "kind_helpful"
    t.integer  "potential"
    t.integer  "perform_well"
    t.integer  "presentable"
    t.integer  "emotianally_mature"
    t.integer  "friendly_social"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "count",              default: 0, null: false
  end

  create_table "reactions", force: true do |t|
    t.text     "reaction_comment"
    t.integer  "praise_id"
    t.integer  "criticism_id"
    t.integer  "general_id"
    t.integer  "provider_user_id"
    t.integer  "reciver_user_id"
    t.integer  "response_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "relationships", force: true do |t|
    t.string   "email"
    t.integer  "know_how_for_long_year"
    t.integer  "know_how_for_long_month"
    t.string   "how_well_you_know_the_person"
    t.string   "your_influence"
    t.string   "influence_on_your"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "how_long_you_know_each_other_avg"
    t.float    "well_known_user_avg"
    t.float    "influence_avg"
    t.integer  "circle_id"
    t.string   "name"
    t.text     "good_coach"
    t.text     "empowers_team"
    t.text     "expresses_interest_concern"
    t.text     "productive_results_oriented"
    t.text     "good_communicator"
    t.text     "helps_with_career_development"
    t.text     "clear_vision_and_strategy"
    t.text     "uses_special_skills_to_advise"
    t.text     "romantic"
    t.boolean  "approve_custom_factor"
    t.string   "your_choise_custom_factor"
    t.boolean  "relation_checked",                 default: false
  end

  create_table "reputation_scores", force: true do |t|
    t.integer  "user_id"
    t.float    "score"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "response_tips", force: true do |t|
    t.integer  "tip_id"
    t.string   "response_for_tip"
    t.string   "tag_tip"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "responses", force: true do |t|
    t.text     "response_comment"
    t.integer  "praise_id"
    t.integer  "criticism_id"
    t.integer  "general_id"
    t.integer  "response_user_id"
    t.integer  "provider_user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", force: true do |t|
    t.integer  "role_id"
    t.integer  "user_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "score_factors", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "factor_type"
  end

  create_table "sponsees", force: true do |t|
    t.integer  "user_id"
    t.integer  "relationship_id"
    t.string   "email"
    t.boolean  "approve_admin_custom_factor"
    t.string   "your_choise_custom_factor"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "custom_factor"
    t.string   "name"
    t.integer  "sponser_id"
  end

  create_table "sponsercfs", force: true do |t|
    t.integer  "sponser_id"
    t.integer  "user_id"
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "custom_factor"
  end

  create_table "sponsers", force: true do |t|
    t.string   "name"
    t.string   "custom_factor"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "subscriptions", force: true do |t|
    t.integer  "plan_id"
    t.integer  "user_id"
    t.string   "name"
    t.string   "email"
    t.float    "price"
    t.string   "paypal_payment_token"
    t.string   "paypal_customer_token"
    t.string   "paypal_recurring_profile_token"
    t.string   "token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "suggestions", force: true do |t|
    t.text     "feedback_comment"
    t.integer  "praise_id"
    t.integer  "criticism_id"
    t.integer  "general_id"
    t.integer  "provider_user_id"
    t.string   "recipient_email"
    t.string   "comment_quality"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tips", force: true do |t|
    t.string   "email"
    t.string   "praise"
    t.string   "criticism"
    t.string   "helpful"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "circle_id"
    t.string   "name"
    t.string   "respond_for_tip"
    t.string   "response_for_tip"
    t.integer  "tip_accept",          default: 0
    t.integer  "tip_reject",          default: 0
    t.integer  "tip_viewed",          default: 0
    t.integer  "tip_prediction",      default: 0
    t.text     "suggestions"
    t.integer  "quality_of_comments"
    t.integer  "relationship_id"
  end

  create_table "trial_days", force: true do |t|
    t.integer  "days"
    t.datetime "created_at"
    t.datetime "updated_at"
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
    t.string   "name"
  end

  create_table "users", force: true do |t|
    t.string   "email",                     default: "",    null: false
    t.string   "password",                  default: "",    null: false
    t.string   "encrypted_password",        default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",             default: 0,     null: false
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
    t.boolean  "is_admin",                  default: false
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
    t.string   "security_question"
    t.boolean  "toggled_status",            default: false
    t.boolean  "primary"
    t.string   "city"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
