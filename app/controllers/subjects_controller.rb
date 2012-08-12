# coding: utf-8

class SubjectsController < ApplicationController

  # GET /terms/:term_identifier/subjects/new
  def new
    @term = Term.find(params[:term_identifier])
    @subject = @term.subjects.new
  end

  # POST /terms/:term_identifier/subjects/new
  def create
    @term = Term.find(params[:term_identifier])
    @subject = @term.subjects.new
    @subject.subject_syllabus_html = params[:subject][:subject_syllabus_html]
    @subject.get_subject_informations

    if @subject.save
      flash[:info] = '教科を追加しました！'
      redirect_to '/terms'
    else
      render action: :new
    end
  end

  # GET /terms/:term_identifier/subjects/:subject_identifier/edit
  def edit
    @term = Term.find(params[:term_identifier])
    @subject = Subject.find(params[:subject_identifier])
  end
end
