class ApplicationController < ActionController::Base
  #Settings


  #layout 'admin'
  layout :layout_by_resource

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  #Permitir cambiar los campos añadidos al Logins
  before_action :configure_permitted_parameters, if: :devise_controller?


  protected
  def layout_by_resource
    if devise_controller? && controller_name == 'sessions' && action_name == 'new' || controller_name == 'passwords' && action_name == 'new'
      'login'
    else
      'admin'
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:account_update) do |u|
      u.permit(:username, :first_name, :last_name, :identification, :phone, :mobile, :country, :city, :state, :address, :account_type, :number_account, :paypal, :skype,
               :email, :password, :password_confirmation, :current_password)
    end

    devise_parameter_sanitizer.for(:sign_up) do |u|
      u.permit(:username, :first_name, :last_name, :identification, :phone, :mobile, :sponsor_id, :country, :city, :state, :address, :account_type, :number_account, :paypal, :skype,
               :email, :password, :password_confirmation, :current_password)
    end
  end

  #Change status of Model after payment creation
  def change_status(object, status)
    object.update_attribute :status, status
  end

  def next_turn(last)
    #Busca el PRIMER turno que este en waiting y sea del level correspondiente
    Turn.where(status: 'waiting', level_id: last.level_id).first
  end

  #Para conceder permisos si tiene ese nivel
  def is_your_level?
    if current_login.level_id >= params[:level_id].to_i
      return true
    else
      redirect_to root_path, alert: 'No tienes permisos para acceder a esta página'
    end
  end

end
