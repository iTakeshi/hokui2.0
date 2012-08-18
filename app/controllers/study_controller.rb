class StudyController < ApplicationController
  layout 'study'

  def term
  end

  # GET /study/:term_identifier/:subject_identifier
  def subject
    @subject = Subject.find(params[:subject_identifier])
  end

  def help
  end
end
