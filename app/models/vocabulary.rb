class Vocabulary < ActiveRecord::Base
  has_many :vocabulary_words
  attr_accessible :vocabulary_name
end
