class CreateVocabularyWords < ActiveRecord::Migration
  def change
    create_table :vocabulary_words do |t|
      t.string :word_en
      t.string :word_ja
      t.integer :vocabulary_id

      t.timestamps
    end
  end
end
