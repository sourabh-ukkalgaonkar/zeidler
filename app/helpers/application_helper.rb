module ApplicationHelper
  CONTROLLERS = ['sessions', 'registrations'].freeze

  def is_session_or_registration?(controller)
    CONTROLLERS.include?(controller)
  end
end
