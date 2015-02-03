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

  def self.current_stage_name
    u = Update.last
    return u.nil? ? nil : Stage.find_by!(code: u.stage).name
  end

end
