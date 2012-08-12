# coding: utf-8

class Term < ActiveRecord::Base

  validates :term_identifier,
    presence: { message: "学期コードを入力してください。" },
    uniqueness: { allow_blank: true, message: "同じ学期コードを持つ学期がすでに存在します。" },
    format: {allow_blank: true, with: /^[1-6](a|b)$/, message: "学期コードの形式が不正です。" }

  validates :term_name,
    presence: true

  validates :term_timetable_img,
    presence: { message: "時間割表をアップロードしてください。" }

  validates :term_timetable_thumb,
    presence: true

  validates :term_timetable_img_content_type,
    format: { allow_blank: true, with: /^image\/(jpeg|png|gif|tiff)$/, message: "画像ファイルの形式が不正です。" }

  def set_term_name
    grade = self.term_identifier[0]
    if self.term_identifier[1] == 'a'
      self.term_name = "#{grade}年前期"
    elsif self.term_identifier[1] == 'b'
      self.term_name = "#{grade}年後期"
    end
  end

  def generate_timetable_thumb
    img = Magick::Image.from_blob(self.term_timetable_img).shift
    self.term_timetable_thumb = img.resize_to_fit(1000, 100).to_blob
  end

  def self.find(term_identifier)
    self.find_by_term_identifier(term_identifier)
  end
end
