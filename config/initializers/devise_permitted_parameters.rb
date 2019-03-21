module DevisePermittedParameters
  extend ActiveSupport::Concern

  included do
    before_filter :configure_permitted_parameters
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :nif])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :nif])
  end

end

DeviseController.send :include, DevisePermittedParameters