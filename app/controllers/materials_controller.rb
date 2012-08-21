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

  # GET /study/:term_identifier/:subject_identifier/new_quiz_file
  def new_quiz
    @material = Material.new(
      subject_identifier: params[:subject_identifier],
      material_type: 1
    )
    @type = 'quiz'
    render :new
  end

  # GET /study/:term_identifier/:subject_identifier/new_summary_file
  def new_summary
    @material = Material.new(
      subject_identifier: params[:subject_identifier],
      material_type: 2,
      material_with_answer: false
    )
    @type = 'summary'
    render :new
  end

  # GET /study/:term_identifier/:subject_identifier/new_personal_file
  def new_personal
    @material = Material.new(
      subject_identifier: params[:subject_identifier],
      material_type: 3,
      material_with_answer: false,
      material_number: 1,
      material_year: 93
    )
    @type = 'personal'
    render :new
  end

  # POST /study/:term_identifier/:subject_identifier/new_exam_file
  def create
    @material = Material.new(params[:material])
    @material.user_id = current_user.id
    @material.get_page
    q_a = ( @material.material_with_answer ? 'a' : 'q' )
    if @material.material_type == 0
      @material.material_number = params[:material_number_base].to_i * 10 + params[:material_number_appending].to_i
      exam_title = get_exam_title(@material.material_number)
      @material.material_file_name = "#{@material.subject.subject_name}#{@material.material_year}#{exam_title}-#{q_a}-#{@material.material_page}"
    end
    if @material.material_type == 1
      @material.material_file_name = "#{@material.subject.subject_name}#{@material.material_year}-#{@material.material_number}-#{q_a}-#{@material.material_page}"
    end
    if @material.material_type == 2
      @material.material_file_name = "#{@material.subject.subject_name}#{@material.material_year}-#{@material.material_number}-#{@material.material_page}"
    end
    if @material.material_type == 3
      @material.material_year = 93
      @material.material_number = 1
      @material.material_file_name = "#{@material.subject.subject_name}-#{@material.material_page}"
    end
    @material.material_file_content_type = params[:material_file].content_type
    @material.material_file_ext = get_extension(@material.material_file_content_type)
    @material.material_download_count = 0

    if @material.save
      File.open( "/var/app/files/hokui/#{@material.id}.#{@material.material_file_ext}", 'wb') do |f|
        f.write(params[:material_file].read)
      end
      flash[:success] = "ファイルのアップロードに成功しました！"
      redirect_to "/study/#{@material.subject.term_identifier}/#{@material.subject_identifier}"
    else
      render :new
    end
  end

  # GET /materials/:material_id/download/:material_file_name
  def download
    material = Material.find(params[:material_id])
    material.increment(:material_download_count)
    send_file "/var/app/files/hokui/#{params[:material_id]}.#{params[:format]}", filename: "#{params[:file_name]}", disposition: 'inline', content_type: material.material_file_content_type
    material.save!
  end

  # GET /materials/:material_id/edit
  def edit
    @material = Material.find(params[:material_id])
  end

  # PUT /materials/:material_id/edit
  def update
    @material = Material.find(params[:material_id])
    p = params[:material]
    @material.subject_identifier = p[:subject_identifier]
    @material.material_type = p[:material_type]
    @material.material_year = p[:material_year]
    @material.material_with_answer = p[:material_with_answer]
    @material.material_comments = p[:material_comments]
    @material.get_page
    q_a = ( @material.material_with_answer ? 'a' : 'q' )
    if @material.material_type == 0
      @material.material_number = params[:material_number_base].to_i * 10 + params[:material_number_appending].to_i
      exam_title = get_exam_title(@material.material_number)
      @material.material_file_name = "#{@material.subject.subject_name}#{@material.material_year}#{exam_title}-#{q_a}-#{@material.material_page}"
    else
      @material.material_number = p[:material_number]
    end
    if @material.material_type == 1
      @material.material_file_name = "#{@material.subject.subject_name}#{@material.material_year}-#{@material.material_number}-#{q_a}-#{@material.material_page}"
    end
    if @material.material_type == 2
      @material.material_file_name = "#{@material.subject.subject_name}#{@material.material_year}-#{@material.material_number}-#{@material.material_page}"
    end
    if params[:material_file]
      @material.material_file_content_type = params[:material_file].content_type
      @material.material_file_ext = get_extension(@material.material_file_content_type)
      File.open( "/var/app/files/hokui/#{@material.id}.#{@material.material_file_ext}", 'wb') do |f|
        f.write(params[:material_file].read)
      end
    end

    if @material.save
      flash[:info] = "ファイル情報を変更しました。"
      redirect_to "/study/#{@material.subject.term_identifier}/#{@material.subject_identifier}"
    else
      render :new
    end
  end

  # GET /materials/delete/:material_id
  def delete
    material = Material.find(params[:material_id])
    unless current_user.user_is_admin or current_user.id == material.user.id
      render json: { status: :forbidden }
      return
    end
    File.delete("/var/app/files/hokui/#{material.id}.#{material.material_file_ext}")
    material.delete
    render json: { status: :success }
  rescue
    render json: { status: :error}
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
