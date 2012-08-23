# coding: utf-8

class Material < ActiveRecord::Base
  belongs_to :user
  belongs_to :subject, primary_key: :subject_identifier, foreign_key: :subject_identifier
  attr_accessible :subject_identifier, :material_type

  validates :subject_identifier,
    presence: { message: "教科名を選択してください。" }

  validates :user_id,
    presence: true

  validates :material_type,
    presence: { message: "ファイルの種類を選択してください。" }

  validates :material_year,
    presence: { message: "年度を選択してください。" }

  validates :material_number,
    presence: { message: "回を選択してください。" }

  validates :material_with_answer,
    inclusion: { in: [true, false] }

  validates :material_page,
    presence: true

  validates :material_file_name,
    presence: true,
    uniqueness: true

  validates :material_file_ext,
    presence: { message: "ファイルが選択されていないか、ファイル形式が不正です。" }

  validates :material_file_content_type,
    presence: true

  validates :material_download_count,
    presence: true

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
