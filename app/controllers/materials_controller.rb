# coding: utf-8

class MaterialsController < ApplicationController
  layout 'study'

  # GET /study/:term_identifier/:subject_identifier/new_exam_file
  def new_exam
    @material = Material.new(
      subject_identifier: params[:subject_identifier],
      material_type: 0
    )
    @type = 'exam'
    render :new
  end
end
