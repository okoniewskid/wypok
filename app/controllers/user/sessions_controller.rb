class User::SessionsController < Devise::SessionsController
# before_action :configure_sign_in_params, only: [:create]

  private
  def after_sign_in_path_for(resource)
    if resource.is_a?(User)
      if resource.has_role? :block
        sign_out resource
        flash[:notice] = "Twoje konto zostało zablokowane."
        new_user_session_path
      else
       super
      end
    end
  end

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
