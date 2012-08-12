class CreateSubjects < ActiveRecord::Migration
  def change
    create_table :subjects do |t|
      t.string :term_identifier, null: false
      t.string :subject_identifier, null: false
      t.string :subject_name, null: false
      t.string :subject_staff, null: false
      t.text :subject_syllabus_html, null: false

      t.timestamps
    end

    add_index :subjects, :term_identifier
    add_index :subjects, :subject_identifier, unique: true
    add_index :subjects, :subject_name, unique: true
  end
end
