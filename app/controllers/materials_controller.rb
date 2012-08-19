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
    @material.material_number = params[:material_number_base].to_i * 10 + params[:material_number_appending].to_i
    @material.user_id = current_user.id
    @material.get_page
    exam_title = get_exam_title(@material.material_number)
    q_a = ( @material.material_with_answer ? 'a' : 'q' )
    @material.material_file_name = "#{@material.subject.subject_name}#{@material.material_year}#{exam_title}-#{q_a}-#{@material.material_page}"
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

private
  def get_exam_title(number)
    base_name = case ( number / 10 )
                when 1
                  '第1回'
                when 2
                  '第2回'
                when 3
                  '第3回'
                when 4
                  '第4回'
                when 5
                  '第5回'
                when 6
                  '第6回'
                when 10
                  '中間'
                when 11
                  '期末'
                end

    appending = case ( number % 10 )
                when 0
                  ''
                when 1
                  '追試'
                when 2
                  '追々試'
                when 3
                  '追々々試'
                end

    return base_name + appending
  end
end
