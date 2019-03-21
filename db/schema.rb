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

ActiveRecord::Schema.define(version: 20190319083253) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "deficiencies", force: :cascade do |t|
    t.integer  "edifici_id"
    t.text     "descripcio"
    t.text     "observacions"
    t.string   "sistema"
    t.string   "qualificacio"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "despeses", force: :cascade do |t|
    t.integer  "edifici_id"
    t.integer  "fase_id"
    t.string   "concepte"
    t.integer  "import"
    t.integer  "data_mes"
    t.integer  "data_any"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "edificis", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "nom_edifici"
    t.string   "ref_cadastral"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "fases", force: :cascade do |t|
    t.integer  "edifici_id"
    t.string   "nom"
    t.integer  "posicio"
    t.text     "observacions"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "identificacions", force: :cascade do |t|
    t.integer  "edifici_id"
    t.string   "tipus_via"
    t.string   "nom_via"
    t.string   "numero_via"
    t.string   "bloc"
    t.string   "codi_postal"
    t.string   "poblacio"
    t.string   "provincia"
    t.string   "regim_juridic"
    t.string   "nom_titular"
    t.string   "nif_titular"
    t.string   "nom_representant"
    t.string   "nif_representant"
    t.string   "nom_tecnic"
    t.string   "nif_tecnic"
    t.string   "titulacio_tecnic"
    t.string   "colegi_tecnic"
    t.string   "num_colegiat_tecnic"
    t.string   "codi_ite"
    t.string   "data_emissio_ite"
    t.string   "nom_redactor_ite"
    t.string   "nif_redactor_ite"
    t.string   "titulacio_redactor_ite"
    t.string   "colegi_redactor_ite"
    t.string   "num_colegiat_redactor_ite"
    t.string   "num_expedient"
    t.string   "vigencia_limit_certificat"
    t.string   "qualificacio_certificat"
    t.string   "data_primera_verificacio"
    t.string   "data_recepcio_informe"
    t.string   "termini_aprovacio_programa"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.string   "foto_facana_file_name"
    t.string   "foto_facana_content_type"
    t.integer  "foto_facana_file_size"
    t.datetime "foto_facana_updated_at"
  end

  create_table "ingressos", force: :cascade do |t|
    t.integer  "edifici_id"
    t.integer  "import"
    t.integer  "data_mes"
    t.integer  "data_any"
    t.boolean  "creat_usuari", default: false
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  create_table "intervencions", force: :cascade do |t|
    t.integer  "edifici_id"
    t.integer  "fase_id"
    t.text     "descripcio"
    t.string   "sistema"
    t.integer  "import_obres",     default: 0
    t.integer  "import_honoraris", default: 0
    t.integer  "import_taxes",     default: 0
    t.integer  "import_altres",    default: 0
    t.integer  "data_inici_any"
    t.integer  "data_inici_mes"
    t.integer  "durada_mesos"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  create_table "planificacions", force: :cascade do |t|
    t.integer  "edifici_id"
    t.integer  "fons_propis"
    t.integer  "subvencions_solicitades"
    t.integer  "subvencions_atorgades"
    t.integer  "import_financar"
    t.string   "forma_financar"
    t.string   "data_financament"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "qualificacions", force: :cascade do |t|
    t.integer  "edifici_id"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.string   "xml_file_file_name"
    t.string   "xml_file_content_type"
    t.integer  "xml_file_file_size"
    t.datetime "xml_file_updated_at"
  end

  create_table "tresoreries", force: :cascade do |t|
    t.integer  "edifici_id"
    t.integer  "import"
    t.integer  "data_mes"
    t.integer  "data_any"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",     null: false
    t.string   "encrypted_password",     default: "",     null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,      null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.string   "first_name"
    t.string   "last_name"
    t.string   "role",                   default: "user"
    t.string   "nif"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

end
