# coding: utf-8

class TermsController < ApplicationController

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
end
