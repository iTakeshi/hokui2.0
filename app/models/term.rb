# coding: utf-8

class Term < ActiveRecord::Base
  def set_term_name
    grade = self.term_identifier[0]
    if self.term_identifier[1] == 'a'
      self.term_name = "#{grade}年前期"
    elsif self.term_identifier[1] == 'b'
      self.term_name = "#{grade}年後期"
    end
  end
end
