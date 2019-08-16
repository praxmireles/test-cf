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

ActiveRecord::Schema.define(version: 2019_06_22_083632) do

  create_table "access_tokens", force: :cascade do |t|
    t.bigint "user_id"
    t.string "provider"
    t.string "token"
    t.datetime "expires_at"
    t.boolean "expired"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_access_tokens_on_user_id"
  end

  create_table "admin_users", force: :cascade do |t|
    t.string "type"
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
  end

  create_table "applicants", force: :cascade do |t|
    t.integer "user_id"
    t.string "type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "applicants_users", id: false, force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "applicant_id", null: false
    t.index ["applicant_id", "user_id"], name: "index_applicants_users_on_applicant_id_and_user_id"
    t.index ["user_id", "applicant_id"], name: "index_applicants_users_on_user_id_and_applicant_id"
  end

  create_table "application_balance_items", force: :cascade do |t|
    t.integer "application_balance_id"
    t.float "amount"
    t.boolean "paid"
    t.integer "appointment_id"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "application_fees"
  end

  create_table "application_balances", force: :cascade do |t|
    t.float "total_amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "appointment_packs", force: :cascade do |t|
    t.bigint "user_id"
    t.string "type", default: "OpenAppointmentPack"
    t.integer "expert_id"
    t.float "price"
    t.text "description"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "service_id"
    t.string "stripe_charge_id"
    t.index ["service_id"], name: "index_appointment_packs_on_service_id"
    t.index ["user_id"], name: "index_appointment_packs_on_user_id"
  end

  create_table "appointment_packs_appointments", force: :cascade do |t|
    t.bigint "appointment_pack_id"
    t.bigint "appointment_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["appointment_id"], name: "index_appointment_packs_appointments_on_appointment_id"
    t.index ["appointment_pack_id"], name: "index_appointment_packs_appointments_on_appointment_pack_id"
  end

  create_table "appointment_suggests", force: :cascade do |t|
    t.bigint "appointment_id"
    t.bigint "user_id"
    t.datetime "start_date"
    t.boolean "accepted", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["appointment_id"], name: "index_appointment_suggests_on_appointment_id"
    t.index ["user_id"], name: "index_appointment_suggests_on_user_id"
  end

  create_table "appointments", force: :cascade do |t|
    t.bigint "user_id"
    t.string "type", default: "OpenAppointment"
    t.integer "expert_id"
    t.integer "service_id"
    t.integer "first_available"
    t.string "video_session_uid"
    t.string "video_session_token"
    t.string "cancel_reason"
    t.string "description"
    t.string "stripe_charge_uid"
    t.string "subject"
    t.datetime "cancelled_on"
    t.boolean "cancelled"
    t.integer "duration_in_min"
    t.integer "time_spent_in_min"
    t.boolean "offline"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "start_date"
    t.datetime "end_date"
    t.string "cancelled_by"
    t.bigint "search_history_id"
    t.bigint "request_id"
    t.float "price"
    t.datetime "completed_on"
    t.datetime "scheduled_on"
    t.boolean "introduction", default: false
    t.string "day_of_week"
    t.datetime "close_on"
    t.boolean "close"
    t.boolean "client_joined", default: false
    t.boolean "expert_joined", default: false
    t.boolean "paid"
    t.boolean "pre_authorized"
    t.string "stripe_charge_id"
    t.index ["request_id"], name: "index_appointments_on_request_id"
    t.index ["search_history_id"], name: "index_appointments_on_search_history_id"
    t.index ["user_id"], name: "index_appointments_on_user_id"
  end

  create_table "availabilities", force: :cascade do |t|
    t.bigint "user_id"
    t.string "day_of_week"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.time "start_time"
    t.time "end_time"
    t.index ["user_id"], name: "index_availabilities_on_user_id"
  end

  create_table "balance_items", force: :cascade do |t|
    t.bigint "balance_id"
    t.bigint "user_id"
    t.float "amount", default: 0.0
    t.boolean "paid", default: true
    t.bigint "appointment_id"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "payout_service"
    t.string "stripe_payout_id"
    t.string "paypal_id"
    t.float "application_fees"
    t.index ["appointment_id"], name: "index_balance_items_on_appointment_id"
    t.index ["balance_id"], name: "index_balance_items_on_balance_id"
    t.index ["user_id"], name: "index_balance_items_on_user_id"
  end

  create_table "balances", force: :cascade do |t|
    t.bigint "user_id"
    t.float "total_amount", default: 0.0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_balances_on_user_id"
  end

  create_table "billings", force: :cascade do |t|
    t.bigint "user_id"
    t.string "street"
    t.string "city"
    t.string "state"
    t.string "zip"
    t.string "country"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "legal_name"
    t.index ["user_id"], name: "index_billings_on_user_id"
  end

  create_table "business_informations", force: :cascade do |t|
    t.integer "user_id"
    t.string "business_name"
    t.string "corporation_number"
    t.string "gst_hst_number"
    t.string "country"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cards", force: :cascade do |t|
    t.bigint "user_id"
    t.string "stripe_card_uid"
    t.string "stripe_card_brand"
    t.string "stripe_card_last4"
    t.string "stripe_card_exp_month"
    t.string "stripe_card_exp_year"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_cards_on_user_id"
  end

  create_table "career_highlights", force: :cascade do |t|
    t.bigint "user_id"
    t.string "name"
    t.string "description"
    t.datetime "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "highest", default: false
    t.index ["user_id"], name: "index_career_highlights_on_user_id"
  end

  create_table "coaching_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "locale"
  end

  create_table "configurations", force: :cascade do |t|
    t.float "express_advice_price"
    t.float "mentoring_price"
    t.float "coaching_price"
    t.float "mentoring_introduction_price"
    t.float "coaching_introduction_price"
    t.integer "auto_cancelation_in_days"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "confirmation_max_days", default: 2
    t.float "service_fees", default: 0.2
    t.integer "remind_in_min_ago"
    t.integer "min_time_to_respond_in_hours", default: 4
    t.integer "expert_enrollment_timeout"
  end

  create_table "contact_informations", force: :cascade do |t|
    t.bigint "user_id"
    t.string "primary_phone"
    t.string "secondary_phone"
    t.string "primary_mobile"
    t.string "secondary_mobile"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "mobile_contact_time"
    t.string "phone_contact_time"
    t.index ["user_id"], name: "index_contact_informations_on_user_id"
  end

  create_table "education_histories", force: :cascade do |t|
    t.bigint "user_id"
    t.string "degree"
    t.string "field_of_study"
    t.datetime "from_date"
    t.datetime "to_date"
    t.boolean "present"
    t.boolean "linkedin_import", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "institution_name"
    t.index ["user_id"], name: "index_education_histories_on_user_id"
  end

  create_table "expired_authorizations", force: :cascade do |t|
    t.integer "payment_id"
    t.integer "appointment_id"
    t.boolean "refund"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "failed_payments", force: :cascade do |t|
    t.integer "client_id"
    t.integer "appointment_id"
    t.string "failure_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "message"
  end

  create_table "failed_payouts", force: :cascade do |t|
    t.integer "expert_id"
    t.integer "balance_id"
    t.float "current_balance_amount"
    t.integer "last_balance_item_id"
    t.string "failure_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "message"
    t.string "payout_service"
  end

  create_table "industries", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "locale"
  end

  create_table "industry_experiences", force: :cascade do |t|
    t.bigint "user_id"
    t.string "name"
    t.integer "experience_in_year"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_industry_experiences_on_user_id"
  end

  create_table "introductions", force: :cascade do |t|
    t.bigint "service_id"
    t.string "name"
    t.integer "duration_in_min"
    t.float "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["service_id"], name: "index_introductions_on_service_id"
  end

  create_table "invoices", force: :cascade do |t|
    t.bigint "user_id"
    t.integer "expert_id"
    t.bigint "payment_id"
    t.integer "appointment_id"
    t.datetime "date"
    t.datetime "due_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "paid_on"
    t.float "amount"
    t.integer "appointment_pack_id"
    t.index ["payment_id"], name: "index_invoices_on_payment_id"
    t.index ["user_id"], name: "index_invoices_on_user_id"
  end

  create_table "job_functions", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "locale"
  end

  create_table "languages", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "code"
    t.string "native_name"
  end

  create_table "notifications", force: :cascade do |t|
    t.string "type", default: "NewNotification"
    t.bigint "user_id"
    t.text "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "action"
    t.string "link"
    t.string "wildcard"
    t.string "prefix"
    t.string "suffix"
    t.string "locale"
    t.index ["user_id"], name: "index_notifications_on_user_id"
  end

  create_table "payments", force: :cascade do |t|
    t.bigint "user_id"
    t.integer "appointment_id"
    t.integer "appointment_pack_id"
    t.float "amount"
    t.string "card_last4"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "charge_id"
    t.string "brand"
    t.string "exp_month"
    t.string "exp_year"
    t.boolean "paid", default: false
    t.string "currency", default: "USD"
    t.string "payout_method"
    t.index ["user_id"], name: "index_payments_on_user_id"
  end

  create_table "profile_industries", force: :cascade do |t|
    t.bigint "profile_id"
    t.bigint "industry_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "years"
    t.index ["industry_id"], name: "index_profile_industries_on_industry_id"
    t.index ["profile_id"], name: "index_profile_industries_on_profile_id"
  end

  create_table "profile_job_functions", force: :cascade do |t|
    t.bigint "profile_id"
    t.bigint "job_function_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["job_function_id"], name: "index_profile_job_functions_on_job_function_id"
    t.index ["profile_id"], name: "index_profile_job_functions_on_profile_id"
  end

  create_table "profile_languages", force: :cascade do |t|
    t.bigint "profile_id"
    t.bigint "language_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["language_id"], name: "index_profile_languages_on_language_id"
    t.index ["profile_id"], name: "index_profile_languages_on_profile_id"
  end

  create_table "profile_seniority_levels", force: :cascade do |t|
    t.bigint "profile_id"
    t.bigint "seniority_level_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["profile_id"], name: "index_profile_seniority_levels_on_profile_id"
    t.index ["seniority_level_id"], name: "index_profile_seniority_levels_on_seniority_level_id"
  end

  create_table "profile_skills", force: :cascade do |t|
    t.bigint "skill_id"
    t.bigint "profile_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["profile_id"], name: "index_profile_skills_on_profile_id"
    t.index ["skill_id"], name: "index_profile_skills_on_skill_id"
  end

  create_table "profiles", force: :cascade do |t|
    t.bigint "user_id"
    t.string "resume"
    t.text "about"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_profiles_on_user_id"
  end

  create_table "ratings", force: :cascade do |t|
    t.bigint "user_id"
    t.integer "expert_id"
    t.bigint "appointment_id"
    t.integer "rate"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "type"
    t.index ["appointment_id"], name: "index_ratings_on_appointment_id"
    t.index ["user_id"], name: "index_ratings_on_user_id"
  end

  create_table "requests", force: :cascade do |t|
    t.bigint "user_id"
    t.string "type", default: "PendingRequest"
    t.boolean "rescheduled"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "expert_id"
    t.bigint "search_history_id"
    t.boolean "time_change_requested", default: false
    t.index ["search_history_id"], name: "index_requests_on_search_history_id"
    t.index ["user_id"], name: "index_requests_on_user_id"
  end

  create_table "search_histories", force: :cascade do |t|
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "first_available"
    t.string "service"
    t.string "functions"
    t.string "skills"
    t.string "seniority_levels"
    t.string "coaching_type"
    t.string "industry"
    t.text "description"
    t.text "achieve_experiences"
    t.text "what_changes"
    t.index ["user_id"], name: "index_search_histories_on_user_id"
  end

  create_table "seniority_levels", force: :cascade do |t|
    t.string "name"
    t.string "short_name"
    t.string "rank"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "locale"
  end

  create_table "services", force: :cascade do |t|
    t.string "type"
    t.integer "duration_in_min"
    t.float "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "shared_documents", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "appointment_id"
    t.string "name"
    t.string "type"
    t.string "file"
    t.boolean "owned_by_client"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["appointment_id"], name: "index_shared_documents_on_appointment_id"
    t.index ["user_id"], name: "index_shared_documents_on_user_id"
  end

  create_table "skills", force: :cascade do |t|
    t.bigint "job_function_id"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "locale"
    t.index ["job_function_id"], name: "index_skills_on_job_function_id"
  end

  create_table "timezones", force: :cascade do |t|
    t.string "name"
    t.integer "utc_difference"
    t.string "continent"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "zone_name"
  end

  create_table "users", force: :cascade do |t|
    t.string "type"
    t.string "first_name"
    t.string "last_name"
    t.string "username"
    t.boolean "active", default: false
    t.string "email"
    t.string "job"
    t.string "company"
    t.string "facebook_url"
    t.string "google_url"
    t.string "linkedin_url"
    t.string "avatar"
    t.string "provider"
    t.string "stripe_customer_id"
    t.float "hourly_rate"
    t.boolean "accepted_privacy_policy", default: false
    t.datetime "accepted_policy_on"
    t.string "facebook_uid"
    t.string "linkedin_uid"
    t.boolean "completed_onboarding", default: false
    t.string "location"
    t.integer "timezone_id"
    t.boolean "coach", default: false
    t.string "last_sign_in_ip"
    t.string "current_sign_in_ip"
    t.datetime "last_sign_in_at"
    t.integer "sign_in_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "current_card_id"
    t.string "locale", default: "en"
    t.string "current_onboarding_step"
    t.string "completed_steps", default: "--- []\n"
    t.string "stripe_account_id"
    t.string "files"
    t.boolean "is_business", default: false
    t.string "default_currency", default: "USD"
    t.string "paypal_email"
    t.string "payout_method"
  end

  create_table "users_services", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "service_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["service_id"], name: "index_users_services_on_service_id"
    t.index ["user_id"], name: "index_users_services_on_user_id"
  end

  create_table "versions", force: :cascade do |t|
    t.string "item_type", null: false
    t.integer "item_id", null: false
    t.string "event", null: false
    t.string "whodunnit"
    t.text "object"
    t.datetime "created_at"
    t.text "object_changes"
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"
  end

  create_table "work_histories", force: :cascade do |t|
    t.bigint "user_id"
    t.string "title"
    t.string "company"
    t.string "location"
    t.datetime "from_date"
    t.datetime "to_date"
    t.boolean "present"
    t.boolean "linkedin_import", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "size"
    t.string "company_url"
    t.index ["user_id"], name: "index_work_histories_on_user_id"
  end

end
