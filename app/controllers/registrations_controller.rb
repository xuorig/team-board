class RegistrationsController < Devise::RegistrationsController
  def new
    @invite_token = params[:token]
    super
  end

  def create
    build_resource(sign_up_params)
    @invite_token = params[:invite_token]
    if @invite_token
      verify_token @invite_token
      resource.accept_invite @invite_token
    end
    resource.save

    yield resource if block_given?
    if resource.persisted?
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_flashing_format?
        sign_up(resource_name, resource)
        respond_with resource, location: after_sign_up_path_for(resource)
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_flashing_format?
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end
  end

  def update
    super
  end
end 