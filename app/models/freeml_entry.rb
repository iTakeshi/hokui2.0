class FreemlEntry < ActiveRecord::Base
  attr_accessible :freeml_body, :freeml_datetime, :freeml_id, :freeml_title, :freeml_user
end
