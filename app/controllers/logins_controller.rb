class LoginsController < ApplicationController
  before_action :authenticate_login!
  before_action :set_login, only: [:wizard_turn, :ref_selection, :my_turns]
  before_action :is_your_level?, only: :wizard_turn
  before_action :is_sponsor?, only: :login_activity

  def index
    @logins = current_login.referrals
  end

  def salir
    sign_out :login if login_signed_in?
    sign_out :manager if manager_signed_in?
  end

  def my_turns
    @turns = @logged.turns.where level_id: 1

    if @logged.level_id > 1
      @turns2 = @logged.turns.where level_id: 2
    end

    if @logged.level_id > 2
      @turns3 = @logged.turns.where level_id: 3
    end

    #Verify if have turn for then update capacity status
    view_context.have_turn?
  end

  def wizard_turn
    @login_level = view_context.what_level(params[:level_id].to_i, @logged)
    #Buscar TODOS ó un referidos que su capacidad de esa fila este en status = 'pagado'
    @referrals = @logged.referrals.where("level_id >= ? AND used = ?", params[:level_id].to_i, false)
  end

  #para seleccionar un referido
  def ref_selection
    #validate Referred
      l = Login.find params[:referred]
      @ref = view_context.what_level(params[:level_id].to_i, l)

      if @ref.status != 'inactive' && @ref.status != 'progress'
        #Verify what level is getting or making a petition
        c = view_context.what_level(params[:level_id].to_i, @logged)
        #Cambiar status capacity
        if change_status(c, 'referido')
          #redirect_to new
          params[:level_id]
          @referred = params[:referred]
          render "turn/new"

          logger.debug "La Capacidad de este turno ha sido referida"
        end
      else
        redirect_to turn_wizard_path, alert: 'Este Usuario Referido no esta Activo'
        logger.debug "Este Usuario Referido no esta Activo #{@ref}"
      end

  end

  #P: Si es el Sponsor
  def login_activity
    #Buscar el login y almacenar
    @login = Login.find params[:id]

  end

private
  def set_login
    @logged = Login.find current_login
  end

  def is_sponsor?
    @login = Login.find params[:id]
    if current_login.id == @login.sponsor_id
      return true
    else
      redirect_to mis_referidos_path, alert: 'No tienes permisos para acceder a esta página'
    end
  end

end
