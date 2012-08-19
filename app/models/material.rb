class Material < ActiveRecord::Base
  belongs_to :user
  belongs_to :subject, primary_key: :subject_identifier, foreign_key: :subject_identifier
  attr_accessible :material_comments, :material_download_count, :material_file_content_type, :material_file_ext, :material_file_name, :material_number, :material_number_alias, :material_page, :material_type, :material_with_answer, :material_year, :subject_identifier, :user
end
