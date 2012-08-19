class CreateMaterials < ActiveRecord::Migration
  def change
    create_table :materials do |t|
      t.string :subject_identifier, null: false
      t.integer :user_id, null: false
      t.integer :material_type, null: false
      t.integer :material_year, null: false
      t.integer :material_number, null: false
      t.string :material_number_alias
      t.boolean :material_with_answer
      t.integer :material_page, null: false
      t.string :material_comments
      t.string :material_file_name, null: false
      t.string :material_file_ext, null: false
      t.string :material_file_content_type, null: false
      t.integer :material_download_count, null: false

      t.timestamps
    end

    add_index :materials, :material_file_name, unique: true
  end
end
