class CreateFreemlEntries < ActiveRecord::Migration
  def change
    create_table :freeml_entries do |t|
      t.integer :freeml_id, null: false
      t.string :freeml_user, null: false
      t.text :freeml_body, null: false
      t.string :freeml_title, null: false
      t.datetime :freeml_datetime, null: false
      t.boolean :freeml_readable, null: false

      t.timestamps
    end

    add_index :freeml_entries, :freeml_id, unique: true
  end
end
