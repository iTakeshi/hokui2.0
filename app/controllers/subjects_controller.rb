# coding: utf-8

class SubjectsController < ApplicationController
  layout 'admin'

  # GET /terms/:term_identifier/subjects/new
  def new
    @term = Term.find(params[:term_identifier])
    @subject = @term.subjects.new
  end

  # POST /terms/:term_identifier/subjects/new
  def create
    @term = Term.find(params[:term_identifier])
    @subject = @term.subjects.new
    if params[:subject][:subject_syllabus_html].blank?
      @no_html_error = true
      render action: :new
      return
    end
    @subject.subject_syllabus_html = params[:subject][:subject_syllabus_html]
    @subject.get_subject_informations

    if @subject.save
      flash[:success] = '教科を追加しました！'
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

  # PUT /terms/:term_identifier/subjects/:subject_identifier/edit
  def update
    @term = Term.find(params[:term_identifier])
    @subject = Subject.find(params[:subject_identifier])
    p = params[:subject]
    @subject.term_identifier = p[:term_identifier]
    @subject.subject_identifier = p[:subject_identifier]
    @subject.subject_name = p[:subject_name]
    @subject.subject_staff = p[:subject_staff]
    @subject.subject_lct_cd = p[:subject_lct_cd]

    if @subject.save
      flash[:info] = '教科情報を修正しました。'
      redirect_to '/terms'
    else
      render action: :edit
    end
  end

  # GET /study/:term_identifier/:subject_identifier/syllabus.html
  def download_syllabus_html
    subject = Subject.find(params[:subject_identifier])
    send_data subject.subject_syllabus_html.scan(/<form.*form>/m).first
  end
end
