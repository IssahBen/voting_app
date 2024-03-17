# frozen_string_literal: true

class ApplicationController < ActionController::Base
  helper_method :current_ballot
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[role first_name last_name])
  end

  def current_ballot
    @current_ballot ||= Ballot.find(session[:ballot_id]) if session[:ballot_id]
  end

  def user_not_admin 
    unless current_user.admin?
      flash[:alert] = "Not Authorized"
      redirect_to root_path
    end 
  end 
end
