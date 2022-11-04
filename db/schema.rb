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

ActiveRecord::Schema[7.0].define(version: 2022_11_04_134822) do
  create_table "model_apis", force: :cascade do |t|
    t.string "home_team"
    t.string "away_team"
    t.integer "home_score"
    t.integer "away_score"
    t.integer "quarter"
    t.string "time"
    t.string "possession"
    t.integer "play_down"
    t.integer "yard_to_10"
    t.string "play_name"
    t.string "qb_name"
    t.string "wr1_name"
    t.string "wr1_route"
    t.boolean "wr1_good_route"
    t.string "wr2_name"
    t.string "wr2_route"
    t.boolean "wr2_good_route"
    t.string "te_name"
    t.string "te_route"
    t.boolean "te_good_route"
    t.string "rb_name"
    t.string "rb_route"
    t.boolean "rb_good_route"
    t.string "received_by"
    t.integer "yards_gained"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "videos", force: :cascade do |t|
    t.string "video_path"
    t.string "thumbnail_path"
    t.string "resolution"
    t.integer "size"
    t.integer "duration"
    t.float "frame_rate"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
