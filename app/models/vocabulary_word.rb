class VocabularyWord < ActiveRecord::Base
  belongs_to :vocabulary
  attr_accessible :vocabulary_id, :word_en, :word_ja
end
