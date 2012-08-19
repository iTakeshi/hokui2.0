# coding: utf-8

class Material < ActiveRecord::Base
  belongs_to :user
  belongs_to :subject, primary_key: :subject_identifier, foreign_key: :subject_identifier
  attr_accessible :material_comments, :material_download_count, :material_file_content_type, :material_file_ext, :material_file_name, :material_number, :material_number_alias, :material_page, :material_type, :material_with_answer, :material_year, :subject_identifier, :user

  def get_page
    existing_materials = Material.where(
      subject_identifier: self.subject_identifier,
      material_type: self.material_type,
      material_year: self.material_year,
      material_number: self.material_number,
      material_with_answer: self.material_with_answer
    )
    self.material_page = ( existing_materials.any? ? existing_materials.maximum(:material_page) + 1 : 1 )
  end
end
