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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20121115051716) do

  create_table "actions", :force => true do |t|
    t.string   "action_type"
    t.datetime "action_date"
    t.string   "action_text"
    t.string   "how"
    t.string   "location",         :limit => 1
    t.string   "vote_type"
    t.string   "result"
    t.integer  "bill_id"
    t.integer  "amendment_id"
    t.integer  "roll_call_id"
    t.integer  "roll_call_number"
    t.integer  "alison_vote_id"
    t.datetime "deleteddate"
    t.string   "committee"
    t.boolean  "is_bir"
  end

  add_index "actions", ["action_date"], :name => "IX_action_date"
  add_index "actions", ["amendment_id"], :name => "IX_amendment_id"
  add_index "actions", ["bill_id"], :name => "IX_bill_id"
  add_index "actions", ["roll_call_id"], :name => "IX_roll_call_id"
  add_index "actions", ["roll_call_number"], :name => "IX_roll_call_number"

  create_table "addresses", :force => true do |t|
    t.string  "address_type",   :limit => 50
    t.string  "address_street", :limit => 100
    t.string  "address_city",   :limit => 100
    t.string  "address_state",  :limit => 10
    t.string  "address_zip",    :limit => 10
    t.string  "phone1",         :limit => 25
    t.string  "phone2",         :limit => 25
    t.string  "fax1",           :limit => 25
    t.string  "fax2",           :limit => 25
    t.string  "toll_free",      :limit => 25
    t.string  "ttyd",           :limit => 50
    t.integer "candidate_id"
    t.integer "person_id"
  end

  add_index "addresses", ["candidate_id"], :name => "IX_candidate_id"
  add_index "addresses", ["person_id"], :name => "IX_person_id"

  create_table "app_configurations", :force => true do |t|
    t.string   "name"
    t.string   "value"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "auth_group", :force => true do |t|
    t.string "name", :limit => 80, :null => false
  end

  add_index "auth_group", ["name"], :name => "name", :unique => true

  create_table "auth_group_permissions", :force => true do |t|
    t.integer "group_id",      :null => false
    t.integer "permission_id", :null => false
  end

  add_index "auth_group_permissions", ["group_id", "permission_id"], :name => "group_id", :unique => true
  add_index "auth_group_permissions", ["group_id"], :name => "auth_group_permissions_425ae3c4"
  add_index "auth_group_permissions", ["permission_id"], :name => "auth_group_permissions_1e014c8f"

  create_table "auth_message", :force => true do |t|
    t.integer "user_id",                       :null => false
    t.text    "message", :limit => 2147483647, :null => false
  end

  add_index "auth_message", ["user_id"], :name => "auth_message_403f60f"

  create_table "auth_permission", :force => true do |t|
    t.string  "name",            :limit => 50,  :null => false
    t.integer "content_type_id",                :null => false
    t.string  "codename",        :limit => 100, :null => false
  end

  add_index "auth_permission", ["content_type_id", "codename"], :name => "content_type_id", :unique => true
  add_index "auth_permission", ["content_type_id"], :name => "auth_permission_1bb8f392"

  create_table "auth_user", :force => true do |t|
    t.string   "username",     :limit => 30,  :null => false
    t.string   "first_name",   :limit => 30,  :null => false
    t.string   "last_name",    :limit => 30,  :null => false
    t.string   "email",        :limit => 75,  :null => false
    t.string   "password",     :limit => 128, :null => false
    t.boolean  "is_staff",                    :null => false
    t.boolean  "is_active",                   :null => false
    t.boolean  "is_superuser",                :null => false
    t.datetime "last_login",                  :null => false
    t.datetime "date_joined",                 :null => false
  end

  add_index "auth_user", ["username"], :name => "username", :unique => true

  create_table "auth_user_groups", :force => true do |t|
    t.integer "user_id",  :null => false
    t.integer "group_id", :null => false
  end

  add_index "auth_user_groups", ["group_id"], :name => "auth_user_groups_425ae3c4"
  add_index "auth_user_groups", ["user_id", "group_id"], :name => "user_id", :unique => true
  add_index "auth_user_groups", ["user_id"], :name => "auth_user_groups_403f60f"

  create_table "auth_user_user_permissions", :force => true do |t|
    t.integer "user_id",       :null => false
    t.integer "permission_id", :null => false
  end

  add_index "auth_user_user_permissions", ["permission_id"], :name => "auth_user_user_permissions_1e014c8f"
  add_index "auth_user_user_permissions", ["user_id", "permission_id"], :name => "user_id", :unique => true
  add_index "auth_user_user_permissions", ["user_id"], :name => "auth_user_user_permissions_403f60f"

  create_table "bill_user_notes", :force => true do |t|
    t.integer  "bill_id"
    t.text     "note"
    t.integer  "user_id"
    t.datetime "created_on"
  end

  create_table "bill_votes", :force => true do |t|
    t.integer  "bill_id"
    t.integer  "user_id"
    t.boolean  "support"
    t.datetime "vote_date"
    t.string   "ip"
    t.integer  "visitors_id"
  end

  add_index "bill_votes", ["bill_id"], :name => "IX_bill_id"
  add_index "bill_votes", ["user_id"], :name => "IX_user_id"
  add_index "bill_votes", ["vote_date"], :name => "IX_vote_date"

  create_table "bills", :force => true do |t|
    t.string   "session_identifier",    :limit => 15
    t.string   "bill_type",             :limit => 3
    t.integer  "number"
    t.datetime "introduced"
    t.integer  "sponsor_id"
    t.integer  "last_action"
    t.datetime "last_vote_date"
    t.string   "last_vote_where",       :limit => 1
    t.integer  "last_vote_roll"
    t.datetime "togovernor_date"
    t.text     "description"
    t.datetime "updated"
    t.datetime "last_action_date"
    t.string   "subject"
    t.string   "current_alison_status"
    t.integer  "current_committee_id"
    t.binary   "disabled",              :limit => 1
    t.string   "last_status",           :limit => 25
    t.text     "current_text"
  end

  add_index "bills", ["bill_type"], :name => "IX_bill_type"
  add_index "bills", ["current_committee_id"], :name => "IX_current_committee_id"
  add_index "bills", ["introduced"], :name => "IX_introduced"
  add_index "bills", ["last_action_date"], :name => "IX_last_action_date"
  add_index "bills", ["last_vote_date"], :name => "IX_last_vote_date"
  add_index "bills", ["session_identifier", "bill_type", "number"], :name => "IX_bill_type_number_session"
  add_index "bills", ["session_identifier"], :name => "IX_session_identifier"
  add_index "bills", ["sponsor_id"], :name => "IX_sponsor_id"

  create_table "bills_amendments", :force => true do |t|
    t.integer  "bill_id"
    t.string   "amendmentidentifier", :limit => 25
    t.datetime "amendmentdate"
    t.string   "type",                :limit => 25
  end

  add_index "bills_amendments", ["amendmentdate"], :name => "IX_amendmentdate"
  add_index "bills_amendments", ["amendmentidentifier"], :name => "IX_amendmentidentifier"
  add_index "bills_amendments", ["bill_id"], :name => "IX_bill_id"
  add_index "bills_amendments", ["type"], :name => "IX_type"

  create_table "bills_committees", :force => true do |t|
    t.integer "bill_id"
    t.integer "committee_id"
    t.string  "activity"
  end

  add_index "bills_committees", ["bill_id"], :name => "IX_bill_id"
  add_index "bills_committees", ["committee_id"], :name => "IX_committee_id"

  create_table "bills_cosponsors", :force => true do |t|
    t.integer  "person_id",    :null => false
    t.integer  "bill_id"
    t.datetime "sponsor_date"
  end

  add_index "bills_cosponsors", ["bill_id"], :name => "IX_bill_id"
  add_index "bills_cosponsors", ["person_id"], :name => "IX_person_id"
  add_index "bills_cosponsors", ["sponsor_date"], :name => "IX_sponsor_date"

  create_table "bills_relations", :force => true do |t|
    t.string  "relation"
    t.integer "bill_id"
    t.integer "related_bill_id"
  end

  add_index "bills_relations", ["bill_id", "related_bill_id"], :name => "IX_bill_id_related_bill_id"
  add_index "bills_relations", ["bill_id"], :name => "IX_bill_id"
  add_index "bills_relations", ["related_bill_id"], :name => "IX_related_bill_id"

  create_table "bills_statuses", :force => true do |t|
    t.integer  "bill_id",                   :null => false
    t.string   "bill_status", :limit => 25, :null => false
    t.datetime "status_date"
  end

  add_index "bills_statuses", ["bill_id"], :name => "bill_id"

  create_table "bills_subjects", :force => true do |t|
    t.integer  "bill_id"
    t.datetime "dateadded"
    t.integer  "subject_id"
  end

  add_index "bills_subjects", ["bill_id", "subject_id"], :name => "IX_subject_id_bill_id"
  add_index "bills_subjects", ["bill_id"], :name => "IX_bill_id"
  add_index "bills_subjects", ["dateadded"], :name => "IX_dateadded"
  add_index "bills_subjects", ["subject_id"], :name => "IX_subject_id"

  create_table "bills_tags", :force => true do |t|
    t.integer "bill_id"
    t.integer "tag_id"
  end

  create_table "bills_text_versions", :force => true do |t|
    t.integer  "bill_id"
    t.string   "version_type", :limit => 5
    t.datetime "version_date"
  end

  add_index "bills_text_versions", ["bill_id"], :name => "IX_bill_id"
  add_index "bills_text_versions", ["version_date"], :name => "IX_version_date"

  create_table "bills_text_versions_contents", :force => true do |t|
    t.integer "bills_text_versions_id"
    t.text    "bill_text_content",      :limit => 16777215
    t.integer "bills_amendments_id"
  end

  add_index "bills_text_versions_contents", ["bill_text_content"], :name => "bill_text_content"
  add_index "bills_text_versions_contents", ["bills_amendments_id"], :name => "idx_bills_amendments_id"
  add_index "bills_text_versions_contents", ["bills_text_versions_id"], :name => "idx_bills_text_versions_id"

  create_table "blog_posts", :force => true do |t|
    t.string   "name"
    t.string   "title"
    t.text     "content"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.integer  "status_id"
    t.text     "description"
    t.string   "slug"
    t.boolean  "comments_enabled"
  end

  create_table "chronograph_job", :force => true do |t|
    t.string   "name",                :limit => 200,        :null => false
    t.string   "frequency",           :limit => 10,         :null => false
    t.text     "params",              :limit => 2147483647
    t.string   "command",             :limit => 200,        :null => false
    t.string   "args",                :limit => 200,        :null => false
    t.boolean  "disabled",                                  :null => false
    t.datetime "next_run"
    t.datetime "last_run"
    t.boolean  "is_running",                                :null => false
    t.boolean  "last_run_successful",                       :null => false
    t.string   "lock_file",                                 :null => false
    t.boolean  "force_run",                                 :null => false
  end

  create_table "chronograph_job_subscribers", :force => true do |t|
    t.integer "job_id",  :null => false
    t.integer "user_id", :null => false
  end

  add_index "chronograph_job_subscribers", ["job_id", "user_id"], :name => "job_id", :unique => true

  create_table "chronograph_log", :force => true do |t|
    t.integer  "job_id",                         :null => false
    t.datetime "run_date",                       :null => false
    t.text     "stdout",   :limit => 2147483647, :null => false
    t.text     "stderr",   :limit => 2147483647, :null => false
    t.boolean  "success",                        :null => false
    t.float    "duration",                       :null => false
  end

  add_index "chronograph_log", ["job_id"], :name => "chronograph_log_751f44ae"

  create_table "clients", :force => true do |t|
    t.string "display_name", :limit => 100, :default => "0", :null => false
  end

  create_table "clients_industries", :force => true do |t|
    t.integer "client_id",   :default => 0, :null => false
    t.integer "industry_id", :default => 0, :null => false
  end

  create_table "comments", :force => true do |t|
    t.text     "comment"
    t.integer  "user_id"
    t.integer  "bill_id"
    t.datetime "created_on"
    t.string   "username",   :limit => 15
    t.string   "title",      :limit => 25
    t.integer  "person_id"
  end

  add_index "comments", ["bill_id"], :name => "IX_bill_id"
  add_index "comments", ["created_on"], :name => "IX_created_on"
  add_index "comments", ["person_id"], :name => "IX_person_id"
  add_index "comments", ["user_id", "bill_id"], :name => "IX_user_id_bill_id"
  add_index "comments", ["user_id", "person_id"], :name => "IX_user_id_person_id"
  add_index "comments", ["user_id"], :name => "IX_user_id"

  create_table "committee_meetings", :force => true do |t|
    t.integer  "committee_id"
    t.datetime "meeting_date"
    t.string   "meeting_location"
    t.string   "meeting_time"
  end

  create_table "committee_meetings_bills", :force => true do |t|
    t.integer "committee_meetings_id"
    t.integer "bill_id"
    t.boolean "public_hearing"
  end

  create_table "committee_role_ranks", :force => true do |t|
    t.string   "role"
    t.integer  "rank"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "committees", :force => true do |t|
    t.string  "committee_name"
    t.string  "subcommittee_name"
    t.boolean "active",                         :default => true
    t.string  "code"
    t.string  "house",             :limit => 1
    t.boolean "isSubcommittee"
  end

  add_index "committees", ["committee_name", "subcommittee_name", "house"], :name => "IX_committee_name_subcommitee_name_house", :unique => true

  create_table "committees_people", :force => true do |t|
    t.integer "committee_id"
    t.integer "person_id"
    t.string  "role"
    t.string  "session_identifier", :limit => 15
  end

  add_index "committees_people", ["committee_id"], :name => "IX_committee_id"
  add_index "committees_people", ["person_id"], :name => "IX_person_id"

  create_table "countries", :force => true do |t|
    t.string "country", :limit => 75, :default => "", :null => false
  end

  create_table "districts", :force => true do |t|
    t.string   "type",            :limit => 25, :null => false
    t.integer  "district_number",               :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "description"
  end

  add_index "districts", ["type", "district_number"], :name => "type_district_number_Indx"

  create_table "django_admin_log", :force => true do |t|
    t.datetime "action_time",                           :null => false
    t.integer  "user_id",                               :null => false
    t.integer  "content_type_id"
    t.text     "object_id",       :limit => 2147483647
    t.string   "object_repr",     :limit => 200,        :null => false
    t.integer  "action_flag",     :limit => 2,          :null => false
    t.text     "change_message",  :limit => 2147483647, :null => false
  end

  add_index "django_admin_log", ["content_type_id"], :name => "django_admin_log_1bb8f392"
  add_index "django_admin_log", ["user_id"], :name => "django_admin_log_403f60f"

  create_table "django_content_type", :force => true do |t|
    t.string "name",      :limit => 100, :null => false
    t.string "app_label", :limit => 100, :null => false
    t.string "model",     :limit => 100, :null => false
  end

  add_index "django_content_type", ["app_label", "model"], :name => "app_label", :unique => true

  create_table "django_session", :primary_key => "session_key", :force => true do |t|
    t.text     "session_data", :limit => 2147483647, :null => false
    t.datetime "expire_date",                        :null => false
  end

  add_index "django_session", ["expire_date"], :name => "django_session_3da3d3d8"

  create_table "django_site", :force => true do |t|
    t.string "domain", :limit => 100, :null => false
    t.string "name",   :limit => 50,  :null => false
  end

  create_table "downloads", :force => true do |t|
    t.integer  "entity_id"
    t.string   "remote_path"
    t.string   "local_path"
    t.datetime "due_date"
    t.string   "file_status",   :limit => 25
    t.string   "report_type",   :limit => 50
    t.string   "form_type",     :limit => 25
    t.datetime "download_date"
    t.datetime "filed_date"
  end

  add_index "downloads", ["entity_id"], :name => "indx_download_entity_id"
  add_index "downloads", ["file_status", "download_date"], :name => "indx_download_date_file_status"
  add_index "downloads", ["remote_path"], :name => "indx_remote_path", :unique => true

  create_table "fiscal_notes", :force => true do |t|
    t.string   "committee", :limit => 100
    t.datetime "note_date"
    t.string   "analyst",   :limit => 50
    t.text     "raw_html",  :limit => 16777215
    t.integer  "bill_id"
  end

  create_table "groups", :force => true do |t|
    t.string "name",        :limit => 20,  :null => false
    t.string "description", :limit => 100, :null => false
  end

  create_table "industries", :force => true do |t|
    t.string "name", :limit => 50, :null => false
  end

  create_table "lobbyist_client", :force => true do |t|
    t.integer  "client_id",       :null => false
    t.integer  "lobbyist_id",     :null => false
    t.datetime "date_added",      :null => false
    t.boolean  "is_active"
    t.integer  "year_registered"
    t.datetime "inactive_date"
  end

  create_table "lobbyist_registrations", :force => true do |t|
    t.integer  "lobbyist_id"
    t.datetime "date_added"
    t.boolean  "is_active"
    t.integer  "year_registered"
    t.datetime "inactive_date"
  end

  create_table "lobbyists", :force => true do |t|
    t.string   "first_name",   :limit => 50
    t.string   "middle_name",  :limit => 50
    t.string   "last_name",    :limit => 50,  :null => false
    t.string   "address1",     :limit => 100, :null => false
    t.string   "address2",     :limit => 100
    t.string   "city",         :limit => 50,  :null => false
    t.string   "state",        :limit => 2,   :null => false
    t.string   "zip",          :limit => 10,  :null => false
    t.string   "phone_number", :limit => 25
    t.date     "date_filed",                  :null => false
    t.integer  "active"
    t.datetime "date_added"
    t.boolean  "is_agency"
  end

  create_table "mentions", :force => true do |t|
    t.string   "url",           :limit => 8000
    t.string   "excerpt",       :limit => 4000
    t.string   "title",         :limit => 1000
    t.string   "source"
    t.datetime "date"
    t.float    "weight"
    t.integer  "owner_id"
    t.string   "owner_type"
    t.string   "search_source"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "meta", :force => true do |t|
    t.integer "user_id",         :limit => 3,  :null => false
    t.string  "first_name",      :limit => 50, :null => false
    t.string  "last_name",       :limit => 50, :null => false
    t.integer "senate_district"
    t.integer "house_district"
  end

  create_table "most_popular", :force => true do |t|
    t.integer "bill_id"
    t.integer "rep_person_id"
    t.integer "sen_person_id"
  end

  create_table "page_view_counts", :force => true do |t|
    t.integer "bill_id"
    t.integer "person_id"
    t.integer "subject_id"
    t.integer "committee_id"
    t.integer "roll_calls_id"
    t.integer "page_view_count"
  end

  create_table "page_views", :force => true do |t|
    t.integer  "bill_id"
    t.string   "ip",            :limit => 15, :null => false
    t.datetime "viewed_on"
    t.integer  "person_id"
    t.integer  "roll_calls_id"
    t.integer  "subject_id"
    t.integer  "committee_id"
    t.integer  "visitors_id"
    t.integer  "client_id"
    t.integer  "lobbyist_id"
    t.integer  "blog_post_id"
  end

  add_index "page_views", ["bill_id"], :name => "IX_bill_id"
  add_index "page_views", ["committee_id"], :name => "IX_committee_id"
  add_index "page_views", ["ip"], :name => "IX_ip"
  add_index "page_views", ["person_id"], :name => "IX_person_id"
  add_index "page_views", ["roll_calls_id"], :name => "IX_vote_id"
  add_index "page_views", ["subject_id"], :name => "IX_subject_id"
  add_index "page_views", ["viewed_on"], :name => "IX_viewed_on"

  create_table "pages", :force => true do |t|
    t.string   "title"
    t.string   "uri_short_name"
    t.text     "content"
    t.boolean  "comments_enabled"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.text     "sidebar_content"
  end

  create_table "people", :force => true do |t|
    t.string  "firstname"
    t.string  "middlename"
    t.string  "lastname"
    t.string  "nickname"
    t.date    "birthday"
    t.string  "gender",            :limit => 1
    t.string  "religion"
    t.string  "url"
    t.string  "party"
    t.string  "osid"
    t.string  "title"
    t.string  "district"
    t.string  "full_name"
    t.string  "email"
    t.float   "user_approval",                  :default => 5.0
    t.text    "biography"
    t.string  "unaccented_name"
    t.string  "youtube_id"
    t.string  "votesmart_id"
    t.integer "memberid"
    t.integer "personid"
    t.string  "suffix"
    t.string  "wikipedia_id"
    t.string  "imsp_candidate_id"
    t.integer "isActive"
    t.string  "twitter_handle"
    t.string  "image_name"
  end

  add_index "people", ["party"], :name => "IX_party"

  create_table "people_meta_data", :force => true do |t|
    t.integer "candidate_id"
    t.text    "family"
    t.string  "home_city",       :limit => 50
    t.string  "home_state",      :limit => 10
    t.string  "birth_date",      :limit => 15
    t.text    "education"
    t.text    "political"
    t.text    "profession"
    t.string  "religion",        :limit => 50
    t.text    "cong_membership"
    t.text    "org_membership"
    t.integer "person_id"
  end

  add_index "people_meta_data", ["person_id"], :name => "IX_people_meta_data_person_id"

  create_table "people_old", :force => true do |t|
    t.string  "firstname"
    t.string  "middlename"
    t.string  "lastname"
    t.string  "nickname"
    t.date    "birthday"
    t.string  "gender",            :limit => 1
    t.string  "religion"
    t.string  "url"
    t.string  "party"
    t.string  "osid"
    t.string  "title"
    t.string  "district"
    t.string  "full_name"
    t.string  "email"
    t.float   "user_approval",                  :default => 5.0
    t.text    "biography"
    t.string  "unaccented_name"
    t.string  "youtube_id"
    t.string  "votesmart_id"
    t.integer "memberid"
    t.integer "personid"
    t.string  "suffix"
    t.string  "wikipedia_id"
    t.string  "imsp_candidate_id"
  end

  add_index "people_old", ["party"], :name => "IX_party"

  create_table "person_ratings", :force => true do |t|
    t.integer   "user_id"
    t.integer   "rating"
    t.integer   "person_id"
    t.datetime  "created_on"
    t.timestamp "updated_on",  :null => false
    t.integer   "visitors_id"
  end

  add_index "person_ratings", ["person_id"], :name => "IX_person_ratings_person_id"
  add_index "person_ratings", ["user_id"], :name => "IX_person_ratings_user_id"

  create_table "roles", :force => true do |t|
    t.integer "person_id",               :null => false
    t.string  "role_type"
    t.date    "startdate"
    t.date    "enddate"
    t.string  "party"
    t.string  "district",  :limit => 10
    t.string  "url"
    t.string  "address"
    t.string  "phone"
    t.string  "email"
  end

  add_index "roles", ["enddate"], :name => "IX_enddate"
  add_index "roles", ["person_id"], :name => "IX_person_id"
  add_index "roles", ["role_type"], :name => "IX_role_type"
  add_index "roles", ["startdate"], :name => "IX_startdate"

  create_table "roll_call_votes", :force => true do |t|
    t.string  "vote",         :limit => 1
    t.integer "roll_call_id"
    t.integer "person_id",                 :null => false
  end

  add_index "roll_call_votes", ["person_id"], :name => "IX_roll_call_votes_person_id"
  add_index "roll_call_votes", ["roll_call_id"], :name => "IX_roll_call_votes_roll_call_id"

  create_table "roll_calls", :force => true do |t|
    t.integer  "number"
    t.string   "location",            :limit => 1
    t.datetime "vote_date"
    t.datetime "updated"
    t.string   "roll_type"
    t.text     "question"
    t.string   "required"
    t.string   "result"
    t.integer  "bill_id"
    t.integer  "amendment_id"
    t.string   "filename"
    t.integer  "ayes",                             :default => 0
    t.integer  "nays",                             :default => 0
    t.integer  "abstains",                         :default => 0
    t.integer  "presents",                         :default => 0
    t.boolean  "democratic_position"
    t.boolean  "republican_position"
    t.boolean  "is_hot",                           :default => false
    t.string   "title"
    t.datetime "hot_date"
    t.integer  "alison_vote_id"
  end

  add_index "roll_calls", ["bill_id"], :name => "IX_roll_calls_bill_id"
  add_index "roll_calls", ["number", "location"], :name => "IX_roll_calls_number_location"
  add_index "roll_calls", ["vote_date"], :name => "IX_roll_calls_vote_date"

  create_table "session", :primary_key => "session_identifier", :force => true do |t|
    t.datetime "start_date"
    t.datetime "end_date"
    t.boolean  "enabled"
    t.string   "session_label"
    t.string   "bill_html_repository"
    t.datetime "legislative_term_begin"
    t.datetime "legislative_term_end"
  end

  create_table "sessions", :primary_key => "session_id", :force => true do |t|
    t.string  "ip_address",    :limit => 16, :default => "", :null => false
    t.string  "user_agent",    :limit => 50,                 :null => false
    t.integer "last_activity",               :default => 0,  :null => false
    t.text    "user_data"
  end

  create_table "sos_entities", :force => true do |t|
    t.string   "entity_name"
    t.string   "entity_link"
    t.string   "entity_address"
    t.datetime "created_date"
    t.string   "entity_type",        :limit => 1
    t.string   "last_office_sought", :limit => 100
    t.boolean  "processed"
    t.string   "party",              :limit => 100
    t.string   "acronym",            :limit => 25
    t.string   "phone_number",       :limit => 15
    t.datetime "date_organized"
    t.string   "entity_status",      :limit => 25
    t.text     "purpose"
    t.string   "chair_person",       :limit => 100
    t.string   "treasurer",          :limit => 100
    t.integer  "entity_master_id"
    t.string   "edited_entity_name", :limit => 765
    t.integer  "openbama_id"
  end

  add_index "sos_entities", ["created_date"], :name => "indx_created_date"
  add_index "sos_entities", ["entity_master_id"], :name => "entities_36c90235"
  add_index "sos_entities", ["entity_name", "entity_address"], :name => "idx_entity_name_address"
  add_index "sos_entities", ["entity_name"], :name => "indx_pac_name"

  create_table "subjects", :force => true do |t|
    t.string "subject"
  end

  create_table "tags", :force => true do |t|
    t.string "tag_name"
  end

  create_table "users", :force => true do |t|
    t.integer "group_id",                :limit => 3,                   :null => false
    t.string  "ip_address",              :limit => 16,                  :null => false
    t.string  "username",                :limit => 15,                  :null => false
    t.string  "password",                :limit => 40,                  :null => false
    t.string  "email",                   :limit => 40,                  :null => false
    t.string  "activation_code",         :limit => 40, :default => "0", :null => false
    t.string  "forgotten_password_code", :limit => 40, :default => "0", :null => false
  end

  add_index "users", ["password"], :name => "IX_users_email", :unique => true
  add_index "users", ["username"], :name => "IX_users_username"

  create_table "users_watch", :force => true do |t|
    t.integer "user_id"
    t.integer "bill_id"
    t.integer "subject_id"
    t.integer "person_id"
  end

  create_table "visitors", :force => true do |t|
    t.datetime "date_visited"
  end

  create_table "web_addresses", :force => true do |t|
    t.string  "web_address_type", :limit => 50
    t.binary  "web_address",      :limit => 100
    t.integer "candidate_id"
    t.integer "person_id"
  end

  add_index "web_addresses", ["person_id"], :name => "IX_web_addresses_person_id"

end
