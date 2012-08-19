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

  # POST /study/:term_identifier/:subject_identifier/new_exam_file
  def create
    @material = Material.new(params[:material])
    @material.user_id = current_user.id
    @material.get_page
    number = ( @material.material_number_alias.blank? ? "第#{@material.material_number}回" : @material.material_number_alias )
    q_a = ( @material.material_with_answer ? 'a' : 'q' )
    @material.material_file_name = "#{@material.material_year}#{@material.subject.subject_name}#{number}-#{q_a}-#{@material.material_page}"
    @material.material_file_content_type = params[:material_file].content_type
    @material.material_file_ext = get_extension(@material.material_file_content_type)
    File.open( "/var/app/files/hokui/#{@material.material_file_name}.#{@material.material_file_ext}", 'wb') do |f|
      f.write(params[:material_file].read)
    end
    @material.material_download_count = 0

    if @material.save
      flash[:success] = "ファイルのアップロードに成功しました！"
      redirect_to "/study/#{@material.subject.term_identifier}/#{@material.subject_identifier}"
    else
      render :new
    end
  end
end
