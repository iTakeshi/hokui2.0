class SubjectsController < ApplicationController

  # GET /terms/:term_identifier/subjects/new
  def new
    @term = Term.find(params[:term_identifier])
    @subject = @term.subjects.new
  end
end
