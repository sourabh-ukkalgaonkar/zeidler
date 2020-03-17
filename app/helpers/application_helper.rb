# frozen_string_literal: true

module ApplicationHelper
  CONTROLLERS = %w[sessions registrations].freeze

  def is_session_or_registration?(controller)
    CONTROLLERS.include?(controller)
  end
end
