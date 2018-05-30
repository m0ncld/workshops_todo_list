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

ActiveRecord::Schema.define(version: 20180529125243) do

  create_table "agile_colors", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "container_id"
    t.string  "container_type"
    t.string  "color"
    t.index ["container_id"], name: "index_agile_colors_on_container_id", using: :btree
    t.index ["container_type"], name: "index_agile_colors_on_container_type", using: :btree
  end

  create_table "agile_data", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "issue_id"
    t.integer "position"
    t.integer "story_points"
    t.index ["issue_id"], name: "index_agile_data_on_issue_id", using: :btree
    t.index ["position"], name: "index_agile_data_on_position", using: :btree
  end

  create_table "api_log_for_plugins", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.text     "plugin_code", limit: 65535,                 null: false
    t.integer  "error_code"
    t.text     "description", limit: 65535
    t.text     "controller",  limit: 65535
    t.text     "action",      limit: 65535
    t.text     "params",      limit: 65535
    t.integer  "user_id"
    t.boolean  "served",                    default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "attachments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "container_id"
    t.string   "container_type", limit: 30
    t.string   "filename",                  default: "", null: false
    t.string   "disk_filename",             default: "", null: false
    t.bigint   "filesize",                  default: 0,  null: false
    t.string   "content_type",              default: ""
    t.string   "digest",         limit: 64, default: "", null: false
    t.integer  "downloads",                 default: 0,  null: false
    t.integer  "author_id",                 default: 0,  null: false
    t.datetime "created_on"
    t.string   "description"
    t.string   "disk_directory"
    t.index ["author_id"], name: "index_attachments_on_author_id", using: :btree
    t.index ["container_id", "container_type"], name: "index_attachments_on_container_id_and_container_type", using: :btree
    t.index ["created_on"], name: "index_attachments_on_created_on", using: :btree
    t.index ["disk_filename"], name: "index_attachments_on_disk_filename", using: :btree
  end

  create_table "auth_sources", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string  "type",              limit: 30,    default: "",    null: false
    t.string  "name",              limit: 60,    default: "",    null: false
    t.string  "host",              limit: 60
    t.integer "port"
    t.string  "account"
    t.string  "account_password",                default: ""
    t.string  "base_dn"
    t.string  "attr_login",        limit: 30
    t.string  "attr_firstname",    limit: 30
    t.string  "attr_lastname",     limit: 30
    t.string  "attr_mail",         limit: 30
    t.boolean "onthefly_register",               default: false, null: false
    t.boolean "tls",                             default: false, null: false
    t.text    "filter",            limit: 65535
    t.integer "timeout"
    t.index ["id", "type"], name: "index_auth_sources_on_id_and_type", using: :btree
  end

  create_table "boards", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "project_id",                   null: false
    t.string  "name",            default: "", null: false
    t.string  "description"
    t.integer "position"
    t.integer "topics_count",    default: 0,  null: false
    t.integer "messages_count",  default: 0,  null: false
    t.integer "last_message_id"
    t.integer "parent_id"
    t.index ["last_message_id"], name: "index_boards_on_last_message_id", using: :btree
    t.index ["project_id"], name: "boards_project_id", using: :btree
  end

  create_table "changes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "changeset_id",                             null: false
    t.string  "action",        limit: 1,     default: "", null: false
    t.text    "path",          limit: 65535,              null: false
    t.text    "from_path",     limit: 65535
    t.string  "from_revision"
    t.string  "revision"
    t.string  "branch"
    t.index ["changeset_id"], name: "changesets_changeset_id", using: :btree
  end

  create_table "changeset_parents", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer "changeset_id", null: false
    t.integer "parent_id",    null: false
    t.index ["changeset_id"], name: "changeset_parents_changeset_ids", using: :btree
    t.index ["parent_id"], name: "changeset_parents_parent_ids", using: :btree
  end

  create_table "changesets", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "repository_id",                    null: false
    t.string   "revision",                         null: false
    t.string   "committer"
    t.datetime "committed_on",                     null: false
    t.text     "comments",      limit: 4294967295
    t.date     "commit_date"
    t.string   "scmid"
    t.integer  "user_id"
    t.index ["committed_on"], name: "index_changesets_on_committed_on", using: :btree
    t.index ["repository_id", "revision"], name: "changesets_repos_rev", unique: true, using: :btree
    t.index ["repository_id", "scmid"], name: "changesets_repos_scmid", using: :btree
    t.index ["repository_id"], name: "index_changesets_on_repository_id", using: :btree
    t.index ["user_id"], name: "index_changesets_on_user_id", using: :btree
  end

  create_table "changesets_issues", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "changeset_id", null: false
    t.integer "issue_id",     null: false
    t.index ["changeset_id", "issue_id"], name: "changesets_issues_ids", unique: true, using: :btree
    t.index ["issue_id"], name: "index_changesets_issues_on_issue_id", using: :btree
  end

  create_table "checklist_template_categories", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string  "name"
    t.integer "position", default: 1
  end

  create_table "checklist_templates", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string  "name"
    t.integer "project_id"
    t.integer "category_id"
    t.integer "user_id"
    t.boolean "is_public"
    t.text    "template_items", limit: 65535
    t.boolean "is_default",                   default: false
    t.integer "tracker_id"
    t.index ["tracker_id"], name: "index_checklist_templates_on_tracker_id", using: :btree
  end

  create_table "checklists", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.boolean  "is_done",                default: false
    t.string   "subject",    limit: 512
    t.integer  "position",               default: 1
    t.integer  "issue_id",                               null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "client_emails", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string  "from_email_address"
    t.string  "to_email_address"
    t.date    "date"
    t.string  "email_subject"
    t.text    "text_body",          limit: 65535
    t.text    "html_body",          limit: 65535
    t.integer "issue_id"
  end

  create_table "code_review_assignments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer "issue_id"
    t.integer "change_id"
    t.integer "attachment_id"
    t.string  "file_path"
    t.string  "rev"
    t.string  "rev_to"
    t.string  "action_type"
    t.integer "changeset_id"
  end

  create_table "code_review_project_settings", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer  "project_id"
    t.integer  "tracker_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "updated_by"
    t.boolean  "hide_code_review_tab",                   default: false
    t.integer  "auto_relation",                          default: 1
    t.integer  "assignment_tracker_id"
    t.text     "auto_assign",              limit: 65535
    t.integer  "lock_version",                           default: 0,     null: false
    t.boolean  "tracker_in_review_dialog",               default: false
  end

  create_table "code_review_user_settings", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer  "user_id",           default: 0, null: false
    t.integer  "mail_notification", default: 0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "code_reviews", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer  "project_id"
    t.integer  "change_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "line"
    t.integer  "updated_by_id"
    t.integer  "lock_version",        default: 0, null: false
    t.integer  "status_changed_from"
    t.integer  "status_changed_to"
    t.integer  "issue_id"
    t.string   "action_type"
    t.string   "file_path"
    t.string   "rev"
    t.string   "rev_to"
    t.integer  "attachment_id"
    t.integer  "file_count",          default: 0, null: false
  end

  create_table "comments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "commented_type", limit: 30,    default: "", null: false
    t.integer  "commented_id",                 default: 0,  null: false
    t.integer  "author_id",                    default: 0,  null: false
    t.text     "comments",       limit: 65535
    t.datetime "created_on",                                null: false
    t.datetime "updated_on",                                null: false
    t.index ["author_id"], name: "index_comments_on_author_id", using: :btree
    t.index ["commented_id", "commented_type"], name: "index_comments_on_commented_id_and_commented_type", using: :btree
  end

  create_table "custom_field_enumerations", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "custom_field_id",                null: false
    t.string  "name",                           null: false
    t.boolean "active",          default: true, null: false
    t.integer "position",        default: 1,    null: false
  end

  create_table "custom_fields", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string  "type",              limit: 30,    default: "",    null: false
    t.string  "name",              limit: 30,    default: "",    null: false
    t.string  "field_format",      limit: 30,    default: "",    null: false
    t.text    "possible_values",   limit: 65535
    t.string  "regexp",                          default: ""
    t.integer "min_length"
    t.integer "max_length"
    t.boolean "is_required",                     default: false, null: false
    t.boolean "is_for_all",                      default: false, null: false
    t.boolean "is_filter",                       default: false, null: false
    t.integer "position"
    t.boolean "searchable",                      default: false
    t.text    "default_value",     limit: 65535
    t.boolean "editable",                        default: true
    t.boolean "visible",                         default: true,  null: false
    t.boolean "multiple",                        default: false
    t.text    "format_store",      limit: 65535
    t.text    "description",       limit: 65535
    t.boolean "ajaxable",                        default: false
    t.boolean "acl_trim_multiple"
    t.index ["id", "type"], name: "index_custom_fields_on_id_and_type", using: :btree
  end

  create_table "custom_fields_projects", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "custom_field_id", default: 0, null: false
    t.integer "project_id",      default: 0, null: false
    t.index ["custom_field_id", "project_id"], name: "index_custom_fields_projects_on_custom_field_id_and_project_id", unique: true, using: :btree
  end

  create_table "custom_fields_roles", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer "custom_field_id", null: false
    t.integer "role_id",         null: false
    t.index ["custom_field_id", "role_id"], name: "custom_fields_roles_ids", unique: true, using: :btree
  end

  create_table "custom_fields_trackers", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "custom_field_id", default: 0, null: false
    t.integer "tracker_id",      default: 0, null: false
    t.index ["custom_field_id", "tracker_id"], name: "index_custom_fields_trackers_on_custom_field_id_and_tracker_id", unique: true, using: :btree
  end

  create_table "custom_settings", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
  end

  create_table "custom_values", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string  "customized_type", limit: 30,    default: "", null: false
    t.integer "customized_id",                 default: 0,  null: false
    t.integer "custom_field_id",               default: 0,  null: false
    t.text    "value",           limit: 65535
    t.index ["custom_field_id"], name: "index_custom_values_on_custom_field_id", using: :btree
    t.index ["customized_type", "customized_id", "custom_field_id"], name: "index_custom_values_ccc", using: :btree
    t.index ["customized_type", "customized_id"], name: "custom_values_customized", using: :btree
  end

  create_table "customer_env_issues", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "issue_id"
    t.integer "customer_env_id"
    t.index ["issue_id", "customer_env_id"], name: "index_customer_env_issues_on_issue_id_and_customer_env_id", unique: true, using: :btree
  end

  create_table "customer_envs", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string  "name"
    t.integer "customer_id"
  end

  create_table "customer_issues", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "issue_id"
    t.integer "customer_id"
    t.boolean "support",     default: false
    t.index ["issue_id", "customer_id"], name: "index_customer_issues_on_issue_id_and_customer_id", unique: true, using: :btree
  end

  create_table "customer_product_issues", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "customer_product_id"
    t.integer "issue_id"
    t.index ["customer_product_id"], name: "fk_rails_646f49a7fa", using: :btree
    t.index ["issue_id"], name: "fk_rails_655d1bfa0b", using: :btree
  end

  create_table "customer_product_projects", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "project_id",          null: false
    t.integer "customer_product_id", null: false
    t.index ["project_id", "customer_product_id"], name: "pr_id_cus_prd_id_uniq", unique: true, using: :btree
  end

  create_table "customer_product_users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "user_id",             null: false
    t.integer "customer_product_id", null: false
    t.index ["user_id", "customer_product_id"], name: "usr_id_cus_prd_id_uniq", unique: true, using: :btree
  end

  create_table "customer_products", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string  "name"
    t.integer "customer_id"
  end

  create_table "customer_project_issues", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "customer_project_id"
    t.integer "issue_id"
    t.index ["customer_project_id"], name: "fk_rails_7a555d66ba", using: :btree
    t.index ["issue_id", "customer_project_id"], name: "c_p_i", unique: true, using: :btree
  end

  create_table "customer_projects", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string  "name"
    t.integer "user_id"
    t.integer "customer_id"
    t.boolean "active"
    t.index ["customer_id"], name: "fk_rails_5b6591ec05", using: :btree
    t.index ["user_id"], name: "fk_rails_1398cc1129", using: :btree
  end

  create_table "customer_users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string  "telephone"
    t.string  "mobile"
    t.integer "user_id"
    t.integer "customer_id"
    t.index ["customer_id"], name: "fk_rails_e49df7775d", using: :btree
    t.index ["user_id"], name: "fk_rails_75fccc7e59", using: :btree
  end

  create_table "customers", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string  "name"
    t.boolean "active", default: false
  end

  create_table "documents", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "project_id",                default: 0,  null: false
    t.integer  "category_id",               default: 0,  null: false
    t.string   "title",                     default: "", null: false
    t.text     "description", limit: 65535
    t.datetime "created_on"
    t.index ["category_id"], name: "index_documents_on_category_id", using: :btree
    t.index ["created_on"], name: "index_documents_on_created_on", using: :btree
    t.index ["project_id"], name: "documents_project_id", using: :btree
  end

  create_table "email_addresses", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id",                    null: false
    t.string   "address",                    null: false
    t.boolean  "is_default", default: false, null: false
    t.boolean  "notify",     default: true,  null: false
    t.datetime "created_on",                 null: false
    t.datetime "updated_on",                 null: false
    t.index ["user_id"], name: "index_email_addresses_on_user_id", using: :btree
  end

  create_table "employee_things", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "thing_type"
    t.string "desc"
    t.string "login"
  end

  create_table "employees", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_polish_ci" do |t|
    t.string   "title"
    t.string   "manager"
    t.string   "department"
    t.string   "telephonenumber"
    t.string   "mobile"
    t.string   "givenname"
    t.string   "sn"
    t.string   "dn"
    t.datetime "whencreated"
    t.datetime "whenchanged"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "mail"
    t.string   "samaccountname"
    t.string   "ipphone"
    t.string   "physicaldeliveryofficename"
    t.integer  "user_id"
  end

  create_table "enabled_modules", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "project_id"
    t.string  "name",       null: false
    t.index ["project_id"], name: "enabled_modules_project_id", using: :btree
  end

  create_table "enumerations", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string  "name",          limit: 30, default: "",    null: false
    t.integer "position"
    t.boolean "is_default",               default: false, null: false
    t.string  "type"
    t.boolean "active",                   default: true,  null: false
    t.integer "project_id"
    t.integer "parent_id"
    t.string  "position_name", limit: 30
    t.index ["id", "type"], name: "index_enumerations_on_id_and_type", using: :btree
    t.index ["project_id"], name: "index_enumerations_on_project_id", using: :btree
  end

  create_table "groups_users", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "group_id", null: false
    t.integer "user_id",  null: false
    t.index ["group_id", "user_id"], name: "groups_users_ids", unique: true, using: :btree
  end

  create_table "import_items", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "import_id",               null: false
    t.integer "position",                null: false
    t.integer "obj_id"
    t.text    "message",   limit: 65535
  end

  create_table "imports", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "type"
    t.integer  "user_id",                                   null: false
    t.string   "filename"
    t.text     "settings",    limit: 65535
    t.integer  "total_items"
    t.boolean  "finished",                  default: false, null: false
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
  end

  create_table "issue_categories", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "project_id",                default: 0,  null: false
    t.string  "name",           limit: 60, default: "", null: false
    t.integer "assigned_to_id"
    t.index ["assigned_to_id"], name: "index_issue_categories_on_assigned_to_id", using: :btree
    t.index ["project_id"], name: "issue_categories_project_id", using: :btree
  end

  create_table "issue_relations", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "issue_from_id",              null: false
    t.integer "issue_to_id",                null: false
    t.string  "relation_type", default: "", null: false
    t.integer "delay"
    t.index ["issue_from_id", "issue_to_id"], name: "index_issue_relations_on_issue_from_id_and_issue_to_id", unique: true, using: :btree
    t.index ["issue_from_id"], name: "index_issue_relations_on_issue_from_id", using: :btree
    t.index ["issue_to_id"], name: "index_issue_relations_on_issue_to_id", using: :btree
  end

  create_table "issue_statuses", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string  "name",               limit: 30, default: "",    null: false
    t.boolean "is_closed",                     default: false, null: false
    t.integer "position"
    t.integer "default_done_ratio"
    t.index ["is_closed"], name: "index_issue_statuses_on_is_closed", using: :btree
    t.index ["position"], name: "index_issue_statuses_on_position", using: :btree
  end

  create_table "issue_time_cards", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "issue_id"
    t.integer "time_card_id"
    t.index ["issue_id"], name: "fk_rails_fdadef84a6", using: :btree
    t.index ["time_card_id"], name: "fk_rails_6d570719df", using: :btree
  end

  create_table "issues", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "tracker_id",                                          null: false
    t.integer  "project_id",                                          null: false
    t.string   "subject",                             default: "",    null: false
    t.text     "description",      limit: 4294967295
    t.date     "due_date"
    t.integer  "category_id"
    t.integer  "status_id",                                           null: false
    t.integer  "assigned_to_id"
    t.integer  "priority_id",                                         null: false
    t.integer  "fixed_version_id"
    t.integer  "author_id",                                           null: false
    t.integer  "lock_version",                        default: 0,     null: false
    t.datetime "created_on"
    t.datetime "updated_on"
    t.date     "start_date"
    t.integer  "done_ratio",                          default: 0,     null: false
    t.float    "estimated_hours",  limit: 24
    t.integer  "parent_id"
    t.integer  "root_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.boolean  "is_private",                          default: false, null: false
    t.datetime "closed_on"
    t.string   "external_nr"
    t.index ["assigned_to_id"], name: "index_issues_on_assigned_to_id", using: :btree
    t.index ["author_id"], name: "index_issues_on_author_id", using: :btree
    t.index ["category_id"], name: "index_issues_on_category_id", using: :btree
    t.index ["created_on"], name: "index_issues_on_created_on", using: :btree
    t.index ["fixed_version_id"], name: "index_issues_on_fixed_version_id", using: :btree
    t.index ["parent_id"], name: "index_issues_on_parent_id", using: :btree
    t.index ["priority_id"], name: "index_issues_on_priority_id", using: :btree
    t.index ["project_id"], name: "issues_project_id", using: :btree
    t.index ["root_id", "lft", "rgt"], name: "index_issues_on_root_id_and_lft_and_rgt", using: :btree
    t.index ["status_id"], name: "index_issues_on_status_id", using: :btree
    t.index ["tracker_id"], name: "index_issues_on_tracker_id", using: :btree
  end

  create_table "journal_details", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "journal_id",                    default: 0,  null: false
    t.string  "property",   limit: 30,         default: "", null: false
    t.string  "prop_key",   limit: 30,         default: "", null: false
    t.text    "old_value",  limit: 4294967295
    t.text    "value",      limit: 4294967295
    t.index ["journal_id"], name: "journal_details_journal_id", using: :btree
  end

  create_table "journals", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "journalized_id",                           default: 0,     null: false
    t.string   "journalized_type",      limit: 30,         default: "",    null: false
    t.integer  "user_id",                                  default: 0,     null: false
    t.text     "notes",                 limit: 4294967295
    t.datetime "created_on",                                               null: false
    t.boolean  "private_notes",                            default: false, null: false
    t.boolean  "visible_for_customers",                    default: false
    t.index ["created_on"], name: "index_journals_on_created_on", using: :btree
    t.index ["journalized_id", "journalized_type"], name: "journals_journalized_id", using: :btree
    t.index ["journalized_id"], name: "index_journals_on_journalized_id", using: :btree
    t.index ["user_id"], name: "index_journals_on_user_id", using: :btree
  end

  create_table "member_roles", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "member_id",      null: false
    t.integer "role_id",        null: false
    t.integer "inherited_from"
    t.index ["inherited_from"], name: "index_member_roles_on_inherited_from", using: :btree
    t.index ["member_id"], name: "index_member_roles_on_member_id", using: :btree
    t.index ["role_id"], name: "index_member_roles_on_role_id", using: :btree
  end

  create_table "members", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id",           default: 0,     null: false
    t.integer  "project_id",        default: 0,     null: false
    t.datetime "created_on"
    t.boolean  "mail_notification", default: false, null: false
    t.index ["project_id"], name: "index_members_on_project_id", using: :btree
    t.index ["user_id", "project_id"], name: "index_members_on_user_id_and_project_id", unique: true, using: :btree
    t.index ["user_id"], name: "index_members_on_user_id", using: :btree
  end

  create_table "messages", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "board_id",                                    null: false
    t.integer  "parent_id"
    t.string   "subject",                     default: "",    null: false
    t.text     "content",       limit: 65535
    t.integer  "author_id"
    t.integer  "replies_count",               default: 0,     null: false
    t.integer  "last_reply_id"
    t.datetime "created_on",                                  null: false
    t.datetime "updated_on",                                  null: false
    t.boolean  "locked",                      default: false
    t.integer  "sticky",                      default: 0
    t.index ["author_id"], name: "index_messages_on_author_id", using: :btree
    t.index ["board_id"], name: "messages_board_id", using: :btree
    t.index ["created_on"], name: "index_messages_on_created_on", using: :btree
    t.index ["last_reply_id"], name: "index_messages_on_last_reply_id", using: :btree
    t.index ["parent_id"], name: "messages_parent_id", using: :btree
  end

  create_table "news", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "project_id"
    t.string   "title",          limit: 60,    default: "", null: false
    t.string   "summary",                      default: ""
    t.text     "description",    limit: 65535
    t.integer  "author_id",                    default: 0,  null: false
    t.datetime "created_on"
    t.integer  "comments_count",               default: 0,  null: false
    t.index ["author_id"], name: "index_news_on_author_id", using: :btree
    t.index ["created_on"], name: "index_news_on_created_on", using: :btree
    t.index ["project_id"], name: "news_project_id", using: :btree
  end

  create_table "open_id_authentication_associations", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "issued"
    t.integer "lifetime"
    t.string  "handle"
    t.string  "assoc_type"
    t.binary  "server_url", limit: 65535
    t.binary  "secret",     limit: 65535
  end

  create_table "open_id_authentication_nonces", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "timestamp",  null: false
    t.string  "server_url"
    t.string  "salt",       null: false
  end

  create_table "project_custom_settings", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "project_id"
    t.integer "custom_setting_id"
  end

  create_table "projects", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name",                                 default: "",    null: false
    t.text     "description",            limit: 65535
    t.string   "homepage",                             default: ""
    t.boolean  "is_public",                            default: true,  null: false
    t.integer  "parent_id"
    t.datetime "created_on"
    t.datetime "updated_on"
    t.string   "identifier"
    t.integer  "status",                               default: 1,     null: false
    t.integer  "lft"
    t.integer  "rgt"
    t.boolean  "inherit_members",                      default: false, null: false
    t.integer  "default_version_id"
    t.integer  "default_assigned_to_id"
    t.index ["lft"], name: "index_projects_on_lft", using: :btree
    t.index ["rgt"], name: "index_projects_on_rgt", using: :btree
  end

  create_table "projects_trackers", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "project_id", default: 0, null: false
    t.integer "tracker_id", default: 0, null: false
    t.index ["project_id", "tracker_id"], name: "projects_trackers_unique", unique: true, using: :btree
    t.index ["project_id"], name: "projects_trackers_project_id", using: :btree
  end

  create_table "queries", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "project_id"
    t.string  "name",                        default: "", null: false
    t.text    "filters",       limit: 65535
    t.integer "user_id",                     default: 0,  null: false
    t.text    "column_names",  limit: 65535
    t.text    "sort_criteria", limit: 65535
    t.string  "group_by"
    t.string  "type"
    t.integer "visibility",                  default: 0
    t.text    "options",       limit: 65535
    t.index ["project_id"], name: "index_queries_on_project_id", using: :btree
    t.index ["user_id"], name: "index_queries_on_user_id", using: :btree
  end

  create_table "queries_roles", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer "query_id", null: false
    t.integer "role_id",  null: false
    t.index ["query_id", "role_id"], name: "queries_roles_ids", unique: true, using: :btree
  end

  create_table "repositories", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "project_id",                       default: 0,     null: false
    t.string   "url",                              default: "",    null: false
    t.string   "login",         limit: 60,         default: ""
    t.string   "password",                         default: ""
    t.string   "root_url",                         default: ""
    t.string   "type"
    t.string   "path_encoding", limit: 64
    t.string   "log_encoding",  limit: 64
    t.text     "extra_info",    limit: 4294967295
    t.string   "identifier"
    t.boolean  "is_default",                       default: false
    t.datetime "created_on"
    t.index ["project_id"], name: "index_repositories_on_project_id", using: :btree
  end

  create_table "roles", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string  "name",                    limit: 30,    default: "",        null: false
    t.integer "position"
    t.boolean "assignable",                            default: true
    t.integer "builtin",                               default: 0,         null: false
    t.text    "permissions",             limit: 65535
    t.string  "issues_visibility",       limit: 30,    default: "default", null: false
    t.string  "users_visibility",        limit: 30,    default: "all",     null: false
    t.string  "time_entries_visibility", limit: 30,    default: "all",     null: false
    t.boolean "all_roles_managed",                     default: true,      null: false
    t.text    "settings",                limit: 65535
  end

  create_table "roles_managed_roles", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "role_id",         null: false
    t.integer "managed_role_id", null: false
    t.index ["role_id", "managed_role_id"], name: "index_roles_managed_roles_on_role_id_and_managed_role_id", unique: true, using: :btree
  end

  create_table "sessions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "session_id"
    t.text     "data",       limit: 16777215
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "settings", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name",                     default: "", null: false
    t.text     "value",      limit: 65535
    t.datetime "updated_on"
    t.index ["name"], name: "index_settings_on_name", using: :btree
  end

  create_table "tasks", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.string   "title"
    t.text     "description", limit: 65535
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.date     "deadline"
  end

  create_table "time_cards", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.datetime "date"
    t.integer  "hours",                             default: 0
    t.integer  "minutes",                           default: 0
    t.string   "customer"
    t.string   "activity"
    t.text     "value",               limit: 65535
    t.string   "module"
    t.integer  "customer_id"
    t.integer  "customer_project_id"
    t.integer  "project_id"
  end

  create_table "time_entries", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "project_id",               null: false
    t.integer  "user_id",                  null: false
    t.integer  "issue_id"
    t.float    "hours",       limit: 24,   null: false
    t.string   "comments",    limit: 1024
    t.integer  "activity_id",              null: false
    t.date     "spent_on",                 null: false
    t.integer  "tyear",                    null: false
    t.integer  "tmonth",                   null: false
    t.integer  "tweek",                    null: false
    t.datetime "created_on",               null: false
    t.datetime "updated_on",               null: false
    t.index ["activity_id"], name: "index_time_entries_on_activity_id", using: :btree
    t.index ["created_on"], name: "index_time_entries_on_created_on", using: :btree
    t.index ["issue_id"], name: "time_entries_issue_id", using: :btree
    t.index ["project_id"], name: "time_entries_project_id", using: :btree
    t.index ["user_id"], name: "index_time_entries_on_user_id", using: :btree
  end

  create_table "tokens", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id",               default: 0,  null: false
    t.string   "action",     limit: 30, default: "", null: false
    t.string   "value",      limit: 40, default: "", null: false
    t.datetime "created_on",                         null: false
    t.datetime "updated_on"
    t.index ["user_id"], name: "index_tokens_on_user_id", using: :btree
    t.index ["value"], name: "tokens_value", unique: true, using: :btree
  end

  create_table "trackers", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string  "name",              limit: 30, default: "",    null: false
    t.boolean "is_in_chlog",                  default: false, null: false
    t.integer "position"
    t.boolean "is_in_roadmap",                default: true,  null: false
    t.integer "fields_bits",                  default: 0
    t.integer "default_status_id"
  end

  create_table "user_preferences", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "user_id",                            default: 0,    null: false
    t.text    "others",               limit: 65535
    t.boolean "hide_mail",                          default: true
    t.string  "time_zone"
    t.integer "favourite_project_id"
    t.index ["user_id"], name: "index_user_preferences_on_user_id", using: :btree
  end

  create_table "user_profiles", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
    t.integer  "user_id"
    t.text     "content",    limit: 65535
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "login",                         default: "",    null: false
    t.string   "hashed_password",    limit: 40, default: "",    null: false
    t.string   "firstname",          limit: 30, default: "",    null: false
    t.string   "lastname",                      default: "",    null: false
    t.boolean  "admin",                         default: false, null: false
    t.integer  "status",                        default: 1,     null: false
    t.datetime "last_login_on"
    t.string   "language",           limit: 5,  default: ""
    t.integer  "auth_source_id"
    t.datetime "created_on"
    t.datetime "updated_on"
    t.string   "type"
    t.string   "identity_url"
    t.string   "mail_notification",             default: "",    null: false
    t.string   "salt",               limit: 64
    t.boolean  "must_change_passwd",            default: false, null: false
    t.datetime "passwd_changed_on"
    t.string   "otp_secret_key"
    t.datetime "otp_time"
    t.boolean  "tfa_login"
    t.datetime "logout_time"
    t.index ["auth_source_id"], name: "index_users_on_auth_source_id", using: :btree
    t.index ["id", "type"], name: "index_users_on_id_and_type", using: :btree
    t.index ["type"], name: "index_users_on_type", using: :btree
  end

  create_table "versions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "project_id",      default: 0,      null: false
    t.string   "name",            default: "",     null: false
    t.string   "description",     default: ""
    t.date     "effective_date"
    t.datetime "created_on"
    t.datetime "updated_on"
    t.string   "wiki_page_title"
    t.string   "status",          default: "open"
    t.string   "sharing",         default: "none", null: false
    t.index ["project_id"], name: "versions_project_id", using: :btree
    t.index ["sharing"], name: "index_versions_on_sharing", using: :btree
  end

  create_table "watchers", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string  "watchable_type", default: "", null: false
    t.integer "watchable_id",   default: 0,  null: false
    t.integer "user_id"
    t.index ["user_id", "watchable_type"], name: "watchers_user_id_type", using: :btree
    t.index ["user_id"], name: "index_watchers_on_user_id", using: :btree
    t.index ["watchable_id", "watchable_type"], name: "index_watchers_on_watchable_id_and_watchable_type", using: :btree
  end

  create_table "wiki_content_versions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "wiki_content_id",                                 null: false
    t.integer  "page_id",                                         null: false
    t.integer  "author_id"
    t.binary   "data",            limit: 4294967295
    t.string   "compression",     limit: 6,          default: ""
    t.string   "comments",        limit: 1024,       default: ""
    t.datetime "updated_on",                                      null: false
    t.integer  "version",                                         null: false
    t.index ["updated_on"], name: "index_wiki_content_versions_on_updated_on", using: :btree
    t.index ["wiki_content_id"], name: "wiki_content_versions_wcid", using: :btree
  end

  create_table "wiki_contents", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "page_id",                                    null: false
    t.integer  "author_id"
    t.text     "text",       limit: 4294967295
    t.string   "comments",   limit: 1024,       default: ""
    t.datetime "updated_on",                                 null: false
    t.integer  "version",                                    null: false
    t.index ["author_id"], name: "index_wiki_contents_on_author_id", using: :btree
    t.index ["page_id"], name: "wiki_contents_page_id", using: :btree
  end

  create_table "wiki_pages", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "wiki_id",                    null: false
    t.string   "title",                      null: false
    t.datetime "created_on",                 null: false
    t.boolean  "protected",  default: false, null: false
    t.integer  "parent_id"
    t.index ["parent_id"], name: "index_wiki_pages_on_parent_id", using: :btree
    t.index ["wiki_id", "title"], name: "wiki_pages_wiki_id_title", using: :btree
    t.index ["wiki_id"], name: "index_wiki_pages_on_wiki_id", using: :btree
  end

  create_table "wiki_redirects", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "wiki_id",              null: false
    t.string   "title"
    t.string   "redirects_to"
    t.datetime "created_on",           null: false
    t.integer  "redirects_to_wiki_id", null: false
    t.index ["wiki_id", "title"], name: "wiki_redirects_wiki_id_title", using: :btree
    t.index ["wiki_id"], name: "index_wiki_redirects_on_wiki_id", using: :btree
  end

  create_table "wikis", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "project_id",             null: false
    t.string  "start_page",             null: false
    t.integer "status",     default: 1, null: false
    t.index ["project_id"], name: "wikis_project_id", using: :btree
  end

  create_table "workflows", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "tracker_id",               default: 0,     null: false
    t.integer "old_status_id",            default: 0,     null: false
    t.integer "new_status_id",            default: 0,     null: false
    t.integer "role_id",                  default: 0,     null: false
    t.boolean "assignee",                 default: false, null: false
    t.boolean "author",                   default: false, null: false
    t.string  "type",          limit: 30
    t.string  "field_name",    limit: 30
    t.string  "rule",          limit: 30
    t.index ["new_status_id"], name: "index_workflows_on_new_status_id", using: :btree
    t.index ["old_status_id"], name: "index_workflows_on_old_status_id", using: :btree
    t.index ["role_id", "tracker_id", "old_status_id"], name: "wkfs_role_tracker_old_status", using: :btree
    t.index ["role_id"], name: "index_workflows_on_role_id", using: :btree
    t.index ["tracker_id"], name: "index_workflows_on_tracker_id", using: :btree
  end

  add_foreign_key "customer_product_issues", "customer_products"
  add_foreign_key "customer_product_issues", "issues"
  add_foreign_key "customer_project_issues", "customer_projects"
  add_foreign_key "customer_project_issues", "issues"
  add_foreign_key "customer_projects", "customers"
  add_foreign_key "customer_projects", "users"
  add_foreign_key "customer_users", "customers", on_delete: :cascade
  add_foreign_key "customer_users", "users", on_delete: :cascade
  add_foreign_key "issue_time_cards", "issues"
  add_foreign_key "issue_time_cards", "time_cards"
end
