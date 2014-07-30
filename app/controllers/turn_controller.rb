class TurnController < ApplicationController
  before_action :authenticate_login!
  before_action :is_owner?, only: :view
  before_action :is_your_level?, only: :index

  def index
    @turns = Turn.where(level_id: params[:level_id], status: 'waiting').offset(5)

    #Buscar el Turn Active de ese level
    @active = Turn.where(level_id: params[:level_id], status: ['active', 'confirmation']).first
    #Buscar los waiting de ese level
    @wfive = Turn.where(level_id: params[:level_id], status: 'waiting').limit(5)

    l = Level.find params[:level_id]
    @title = "Fila de $#{l.amount}"
  end

  def view
    @turn = Turn.find params[:id]

    #if @turn.payments.where sent: true, received: false
    #  flash.now.notice = 'Aún no has confirmado algunos PAGOS. Recuerda que los demás están ESPERANDO'
    #end
  end

  #From this method call to private method after validate it
  def new
      #si el status del capacities es referido
      if status_valid?('referido')
        @new_turn = Turn.new
      else
        redirect_to 'logins/my_turn', alert: 'No estas calificado para crear Turno'
        logger.debug "Intento de Creación de Turno sin Calificar"
      end
  end

  #this action will create the Turn
  def create
    if status_valid?('referido')
    @new_turn = Turn.new(params[:turns])

    @new_turn.level_id = params[:level_id]
    @new_turn.login_id = params[:login_id]
    @new_turn.referred = params[:referred]

    if @new_turn.save
      #after create turn, change Capacity status to Active
      change_capacity_status(params[:level_id].to_i)
      #Cambiar estatus del Login
      change_status @new_turn.login, 'Active'
      #Cambiar el REferido a USADO
      change_login_used(params[:referred], true)
      #redireccion
      redirect_to my_turns_path, notice: 'El Turno ha sido creado'
    end
    end
  end

  private
  def status_valid?(status)
    c = view_context.what_level(params[:level_id].to_i, current_login)

    if c.status == status
      return true
    else
      redirect_to root_path, alert: 'No tienes permisos para acceder a esta página'
    end
  end

  def change_capacity_status(level)
    c = view_context.what_level(level, current_login)
    c.update_attribute :status, 'active'
  end

  def is_owner?
    @turn = Turn.find(params[:id])

    if current_login.id == @turn.login_id
      return true
    else
      redirect_to root_path, alert: 'No tienes permisos para acceder a esta página'
    end
  end


end
