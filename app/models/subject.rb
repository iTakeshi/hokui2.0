# coding: utf-8

class Subject < ActiveRecord::Base
  belongs_to :term, primary_key: :term_identifier, foreign_key: :term_identifier

  validates :term_identifier,
    presence: { message: "学期コードを入力してください。" },
    format: { allow_blank: true, with: /^[1-6](a|b)$/, message: "学期コードの形式が不正です。" }

  validates :subject_identifier,
    presence: { message: "教科名（英）を入力してください。" },
    uniqueness: { allow_blank: true, message: "同じ教科名（英）を持つ教科がすでに存在します。" },
    format: { allow_blank: true, with: /^[a-z]+[a-z0-9_]+$/, message: "教科名（英）の形式が不正です。" }

  validates :subject_name,
    presence: { message: "教科名（日）を入力してください。" },
    uniqueness: { allow_blank: true, message: "同じ教科名（日）を持つ教科がすでに存在します。" }

  validates :subject_staff,
    presence: { message: "教員名を入力してください。" }

  validates :subject_lct_cd,
    uniqueness: { allow_blank: true, message: "同じ教科コードを持つ教科がすでに存在します。" }

  validates :subject_syllabus_html,
    presence: { message: "htmlソースを貼りつけてください。" }

  def get_subject_informations
    html = Nokogiri::HTML(self.subject_syllabus_html)
    self.subject_identifier = html.css("#Detail_lbl_sbj_name_e").children[0].text.gsub(/(\)|\[|\])/, '').sub('(', '_').gsub(' ', '_').sub('Ⅰ', '_1').sub('Ⅱ', '_2').downcase.strip
    self.subject_name = html.css("#Detail_lbl_sbj_name").children[0].text.strip
    self.subject_staff = html.css("#Detail_lbl_admin_staff_alias").children[0].text.split('[')[0].sub('　', ' ').strip
    self.subject_lct_cd = html.css("#Detail_lbl_lct_cd").children[0].text.strip
  end

  def self.find(subject_identifier)
    self.find_by_subject_identifier(subject_identifier)
  end
end
