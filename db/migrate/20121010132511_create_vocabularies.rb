class CreateVocabularies < ActiveRecord::Migration
  def change
    create_table :vocabularies do |t|
      t.string :vocabulary_name

      t.timestamps
    end
    add_index :vocabularies, :vocabulary_name, unique: true
  end
end
