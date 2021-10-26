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

ActiveRecord::Schema.define(version: 2021_10_19_150245) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_appointments", force: :cascade do |t|
    t.string "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "appointment_id"
    t.bigint "patient_plan_id"
    t.index ["appointment_id"], name: "index_active_appointments_on_appointment_id"
    t.index ["patient_plan_id"], name: "index_active_appointments_on_patient_plan_id"
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "appointment_logs", force: :cascade do |t|
    t.string "status"
    t.integer "patient_id"
    t.integer "doctor_id"
    t.integer "patient_plan_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "appointments", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "doctor_id"
    t.bigint "patient_id"
    t.integer "case_number"
    t.index ["doctor_id"], name: "index_appointments_on_doctor_id"
    t.index ["patient_id"], name: "index_appointments_on_patient_id"
  end

  create_table "areas", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "status"
  end

  create_table "banks", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "status"
  end

  create_table "chats", force: :cascade do |t|
    t.bigint "doctor_id", null: false
    t.bigint "patient_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["doctor_id"], name: "index_chats_on_doctor_id"
    t.index ["patient_id"], name: "index_chats_on_patient_id"
  end

  create_table "clinical_documents", force: :cascade do |t|
    t.text "info"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "appointment_id"
    t.index ["appointment_id"], name: "index_clinical_documents_on_appointment_id"
  end

  create_table "companies", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "diagnostics", force: :cascade do |t|
    t.string "code"
    t.string "diagnostic"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "report_id"
    t.index ["report_id"], name: "index_diagnostics_on_report_id"
  end

  create_table "diseases", force: :cascade do |t|
    t.string "diagnostic_code"
    t.string "diagnostic_des"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "doctors", force: :cascade do |t|
    t.string "name"
    t.string "middle_name"
    t.string "last_name"
    t.string "surname"
    t.string "document"
    t.string "phone"
    t.string "gender"
    t.string "mail"
    t.date "birthday"
    t.string "specialty"
    t.string "status"
    t.text "address"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "area_id"
    t.bigint "user_id"
    t.text "firm"
    t.string "ficha"
    t.string "rif"
    t.string "sanidad"
    t.string "code_doctor"
    t.string "status_file"
    t.index ["area_id"], name: "index_doctors_on_area_id"
    t.index ["user_id"], name: "index_doctors_on_user_id"
  end

  create_table "insurances", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "insured_patients", force: :cascade do |t|
    t.string "status"
    t.string "code"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "insurance_id"
    t.bigint "patient_id"
    t.bigint "plan_id"
    t.bigint "company_id"
    t.index ["company_id"], name: "index_insured_patients_on_company_id"
    t.index ["insurance_id"], name: "index_insured_patients_on_insurance_id"
    t.index ["patient_id"], name: "index_insured_patients_on_patient_id"
    t.index ["plan_id"], name: "index_insured_patients_on_plan_id"
  end

  create_table "medical_plans", force: :cascade do |t|
    t.string "payment_type"
    t.string "reference_number"
    t.string "status"
    t.date "payment_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "doctor_id"
    t.bigint "plan_id"
    t.bigint "bank_id"
    t.integer "count"
    t.index ["bank_id"], name: "index_medical_plans_on_bank_id"
    t.index ["doctor_id"], name: "index_medical_plans_on_doctor_id"
    t.index ["plan_id"], name: "index_medical_plans_on_plan_id"
  end

  create_table "messages", force: :cascade do |t|
    t.text "content"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id", null: false
    t.bigint "chat_id"
    t.index ["chat_id"], name: "index_messages_on_chat_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "offers", force: :cascade do |t|
    t.string "description"
    t.string "code_offer"
    t.string "status"
    t.text "image"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "password_requests", force: :cascade do |t|
    t.string "user_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "status"
  end

  create_table "patient_plans", force: :cascade do |t|
    t.string "payment_type"
    t.string "reference_number"
    t.string "status"
    t.date "payment_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "patient_id"
    t.bigint "plan_id"
    t.bigint "bank_id"
    t.integer "count"
    t.string "payment_to"
    t.string "type_plan"
    t.index ["bank_id"], name: "index_patient_plans_on_bank_id"
    t.index ["patient_id"], name: "index_patient_plans_on_patient_id"
    t.index ["plan_id"], name: "index_patient_plans_on_plan_id"
  end

  create_table "patients", force: :cascade do |t|
    t.string "name"
    t.string "middle_name"
    t.string "last_name"
    t.string "surname"
    t.string "document"
    t.string "phone"
    t.string "gender"
    t.string "marital_status"
    t.string "mail"
    t.date "birthday"
    t.string "status"
    t.text "address"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id"
    t.string "status_file"
    t.index ["user_id"], name: "index_patients_on_user_id"
  end

  create_table "plans", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.float "cost"
    t.integer "total_appointments"
    t.string "status"
    t.string "image"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "code"
    t.string "type_plan"
  end

  create_table "prescriptions", force: :cascade do |t|
    t.string "medicine"
    t.text "use"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "appointment_id"
    t.index ["appointment_id"], name: "index_prescriptions_on_appointment_id"
  end

  create_table "reports", force: :cascade do |t|
    t.text "reason"
    t.text "disease"
    t.text "past"
    t.text "exam"
    t.text "diagnostic"
    t.text "prescription_des"
    t.text "medicine"
    t.text "use"
    t.date "report_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "appointment_id"
    t.index ["appointment_id"], name: "index_reports_on_appointment_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "login_status", default: "Login"
    t.string "user_type"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "status"
    t.string "busy"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "chats", "doctors"
  add_foreign_key "chats", "patients"
  add_foreign_key "messages", "chats"
  add_foreign_key "messages", "users"
end
