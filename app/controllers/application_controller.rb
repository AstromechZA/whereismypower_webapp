class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  def not_found
    render 'error_pages/not_found'
  end

  def self.current_stage
    u = Update.last
    return u.nil? ? nil : u.stage
  end

  def self.convert_stage_code_to_name(stage)
    case stage
    when 1
      'Stage 1'
    when 2
      'Stage 2'
    when 3
      'Stage 3A'
    when 4
      'Stage 3B'
    else
      nil
    end
  end

end
