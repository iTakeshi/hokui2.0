module ApplicationHelper

  def slice_error_message(msg)
    msg.split(' ').last
  end
end
