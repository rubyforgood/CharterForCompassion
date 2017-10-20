class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    added_attrs = [{skill_ids: [], interest_ids: [] }, :first_name, :last_name, :email, :private, :street1, :street2, :street3, :city, :state, :zipcode, :password, :password_confirmation]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit(:account_update) do |user_params|
      user_params.permit({skill_ids: [], interest_ids: [] }, :first_name, :last_name, :email, :private, :street1, :street2, :street3, :city, :state, :zipcode, :password, :password_confirmation, :current_password)
    end

  end
end
