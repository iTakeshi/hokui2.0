class FreemlEntry < ActiveRecord::Base
  attr_accessible :freeml_body, :freeml_datetime, :freeml_id, :freeml_title, :freeml_user, :freeml_readable

  def self.find(id)
    self.find_by_freeml_id(id)
  end
end
