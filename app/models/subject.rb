# coding: utf-8

class Subject < ActiveRecord::Base
  belongs_to :term, primary_key: :term_identifier, foreign_key: :term_identifier
  attr_accessible :subject_identifier, :subject_name, :subject_staff, :subject_syllabus_html, :term_identifier

  def get_subject_informations
    html = Nokogiri::HTML(self.subject_syllabus_html)
    self.subject_identifier = html.css("#Detail_lbl_sbj_name_e").children[0].text.gsub(/(\)|\[|\])/, '').sub('(', '_').downcase.strip
    self.subject_name = html.css("#Detail_lbl_sbj_name").children[0].text.strip
    self.subject_staff = html.css("#Detail_lbl_admin_staff_alias").children[0].text.split('[')[0].sub('　', ' ').strip
    self.subject_lct_cd = html.css("#Detail_lbl_lct_cd").children[0].text.strip
  end

  def self.find(subject_idntifier)
    self.find_by_subject_identifier(subject_identifier)
  end
end
