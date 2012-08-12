class Subject < ActiveRecord::Base
  attr_accessible :subject_identifier, :subject_name, :subject_staff, :subject_syllabus_html, :term_identifier
end
