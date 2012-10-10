class VocabulariesController < ApplicationController

  # GET /vocabularies
  def index
    @vocabularies = Hash.new
    Vocabulary.all.each do |vocabulary|
      @vocabularies["#{vocabulary.vocabulary_name}"] = vocabulary.vocabulary_words.count
    end
  end

  # GET /vocabularies/new
  def new
  end

  # POST /vocabularies/create
  def create
    vocabulary = Vocabulary.new(vocabulary_name: params[:vocabulary_name])
    if vocabulary.save
      params[:words].split("\r\n").each do |word|
        vocabulary.vocabulary_words.create(
          word_ja: word.split(',')[0].strip,
          word_en: word.split(',')[1].strip
        )
      end
      redirect_to '/vocabularies'
    else
      render :new
    end
  end
end
