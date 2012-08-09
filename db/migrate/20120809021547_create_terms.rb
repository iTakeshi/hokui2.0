class CreateTerms < ActiveRecord::Migration
  def change
    create_table :terms do |t|
      t.string :term_name, null: false
      t.binary :term_timetable_img, null: false
      t.string :term_timetable_img_content_type, null: false

      t.timestamps
    end

    add_index :terms, :term_name, unique: true
  end
end
