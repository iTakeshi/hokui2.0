class FreemlEntry < ActiveRecord::Base
  attr_accessible :freeml_body, :freeml_datetime, :freeml_id, :freeml_title, :freeml_user, :freeml_readable

  validates :freeml_id,
    presence: true,
    uniqueness: true

  validates :freeml_user,
    presence: true

  validates :freeml_body,
    presence: true

  validates :freeml_title,
    presence: true

  validates :freeml_datetime,
    presence: true

  validates :freeml_readable,
    inclusion: { in: [true, false] }

  def self.find(id)
    self.find_by_freeml_id(id)
  end
end
