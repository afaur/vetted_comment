require 'active_record'

ActiveRecord::Base.establish_connection adapter: 'sqlite3', database: ':memory:'

ActiveRecord::Schema.define do
  self.verbose = false

  create_table :comments, id: false, force: :true do |t|
    t.string   "id",  limit: 36
    t.string   "body"
    t.string   "tone"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["id"], name: "index_comments_on_id", unique: true
  end
end

