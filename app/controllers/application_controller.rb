class ApplicationController < ActionController::Base
  before_action :authenticate_user!, unless: [:devise_controller?, :salvar_password_path, :solicitar_password_path]
  before_action :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery unless: -> { request.format.json? }
  include Pundit

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:user_type])
  end

  private

  def user_not_authorized
    # TODO: translate
    message = 'No tienes permiso para realizar esta acción.'
    respond_to do |format|
      format.json do
        render json: { errors: message }, status: :forbidden
      end
      format.html do
        flash[:alert] = message
        redirect_to(request.referer || root_path)
      end
    end
  end
  
end
