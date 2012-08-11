# coding: utf-8

class TermsController < ApplicationController
  before_filter :authorize_as_admin

  # GET /terms/new
  def new
    @term = Term.new
  end

  # POST /terms/new
  def create
    @term = Term.new
    @term.term_identifier = params[:term][:term_identifier]
    @term.set_term_name
    if params[:term][:term_timetable_img].respond_to?(:read)
      img = params[:term][:term_timetable_img]
      @term.term_timetable_img = img.read
      @term.term_timetable_img_content_type = img.content_type
    end

    if @term.save
      flash[:info] = '新学期を追加しました！'
      redirect_to '/terms'
    else
      render action: :new
    end
  end

  # GET /terms/:term_identifier/edit
  def edit
    @term = Term.find(params[:term_identifier])
  end

  # POST /terms/:term_identifier/edit
  def update
    @term = Term.find(params[:term_identifier])
    if params[:term_timetable_img].respond_to?(:read)
      img = params[:term_timetable_img]
      @term.term_timetable_img = img.read
      @term.term_timetable_img_content_type = img.content_type
    end

    if @term.save
      flash[:info] = '時間割表を更新しました。'
      redirect_to '/terms'
    else
      render action: :edit
    end
  end

  # GET /terms
  def index
    @terms = Term.all
  end

  # GET /terms/:term_identifier/img/:file_name
  def download_timetable_img
    term = Term.find(params[:term_identifier])
    send_data term.term_timetable_img, type: term.term_timetable_img_content_type, filename: params[:file_name], disposition: 'inline'
  end
end
