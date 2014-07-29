class PaymentsController < ApplicationController
  before_action :authenticate_login!
  before_action :set_payment, only: [:show, :edit, :update, :destroy, :confirmation, :payment_sent, :payment_received]
  before_action :is_beneficiary?, only: [:confirmation]
  before_action :is_sender?, only: [:show]

  # GET /payments
  # GET /payments.json
  def index
    @payments = current_login.payments

  end

  # GET /payments/1
  # GET /payments/1.json
  def show
  end

  def confirmation
  end

  # GET /payments/new
  def new
    if view_context.have_capacity?(params[:level_id].to_i)
      @turnp = Turn.find params[:turn_id]
      @payment = Payment.new
      @gateways = [
          [@turnp.login.account_type, @turnp.login.account_type],
          [@turnp.login.account_type2, @turnp.login.account_type2],
          [@turnp.login.account_type3, @turnp.login.account_type3],
          ['Western Union', 'Western Union'],
          ['Paypal', 'Paypal']
      ]
      @gateways.delete(1) if @turnp.login.number_account2.nil?
      @gateways.delete(2) if @turnp.login.number_account3.nil?
      @gateways.delete(4) if @turnp.login.paypal.nil?

    else
      redirect_to root_path, alert: 'Actualmente no tienes Capacidad para realizar un Pago. Espera que tu Turno este completado'
    end

  end


  # GET /payments/1/edit
  def edit
  end

  # POST /payments
  # POST /payments.json
  def create
    #Aqui en el params le añadi el objeto porque esta siendo pasado por un form_for
    if view_context.have_capacity?(params[:payment][:level_id].to_i)
    @payment = Payment.new(permitir)

    #Find Turn from id got in view new
    @turnp = Turn.find @payment.turn_id
    #Assign variables to instace
    @payment.level_id = @turnp.level_id
    @payment.amount = @turnp.level.amount

    #Find the Logins
    @user = Login.find current_login.id
    @user_to = Login.find @turnp.login_id

    #add logins to payments
    @payment.login = @user
    @payment.beneficiary = @user_to

    respond_to do |format|
      if @payment.save
        #Cambiar status de la capacidad del p.login a progress
        c = view_context.what_level(@payment.level_id, @payment.login)
        change_status(c, 'progress')

       #change_status of turn to confirmation if have 5
        change_status(@turnp, 'confirmation') if @turnp.payments.size == 5

        format.html { redirect_to @payment, notice: 'El Pago ha sido APARTADO. Ahora debe realizarlo y confirmar' }
        format.json { render :show, status: :created, location: @payment }
      else
        format.html { render :new }
        format.json { render json: @payment.errors, status: :unprocessable_entity }
      end
    end
    end #end have_capacity?
  end

  # PATCH/PUT /payments/1
  # PATCH/PUT /payments/1.json
  def update
    respond_to do |format|
      if @payment.update(payment_params)
        format.html { redirect_to @payment, notice: 'Payment was successfully updated.' }
        format.json { render :show, status: :ok, location: @payment }
      else
        format.html { render :edit }
        format.json { render json: @payment.errors, status: :unprocessable_entity }
      end
    end
  end


  def upload
    uploaded_io = params[:receipt]
    File.open(Rails.root.join('public', 'uploads', uploaded_io.original_filename), 'wb') do |file|
      file.write(uploaded_io.read)
      redirect_to @payment, notice: 'Imagen subida'
    end
  end


  def payment_sent
    if request.patch?
    if @payment.login.id == current_login.id
      if @payment.update_attribute :sent, true
        #adding Comment
        if !params[:comment].nil?
          @payment.update_attribute :comment, params[:comment]
        end
        redirect_to @payment, notice: 'Su pago ha sido enviado. Ahora debe esperar la confirmación'
      end
    else
      redirect_to @payment, alert: I18n.t('payments.payment_sent')
    end
    end
  end

  #Change Payment Received field
  def payment_received
      if @payment.beneficiary.id == current_login.id
        if @payment.update_attribute :received, true
          redirect_to view_turn_url(@payment.turn_id), notice: 'El pago ha sido confirmado exitosamente.'
          change_status_by_payment(@payment)
        end
      else
        redirect_to @payment, alert: I18n.t('payments.payment_sent')
      end
  end

  private
  #Cambia el status luego del ultimo pago
  def change_status_by_payment(p)
    @payment = p
    if view_context.completed_turn?(@payment.turn)
      #Change status of actual Turn
      if change_status(@payment.turn, 'completed')
        #change status of capacity of user beneficiario
        pl = view_context.what_level(@payment.level_id, @payment.beneficiary)
        change_status(pl, 'inactive')

        #----------------------------------------------
        #NEW CAPACITIES
        #----------------------------------------------
        t = view_context.how_many_turns('completed')
        if t == 1
        #Create New Capacity for Fila $75 (Level 2)
          current_login.capacities.create!({name: 'intermediate', level_id: 2, login_id: current_login.id })
        #New level for the Login
          current_login.update_attribute :level_id, 2

          flash.now.notice = 'FELICIDADES! Ahora puedes crear Turnos en la Fila de $75'

        end
        if t == 2
        #Create New Capacity for Fila $125 (Level 3)
          current_login.capacities.create!({name: 'advanced', level_id: 3, login_id: current_login.id })
          current_login.update_attribute :level_id, 3

          flash.now.notice = 'FELICIDADES! Ahora puedes crear Turnos en la Fila de $125'
        end
        #----------------------------------------------
        # /END/ NEW CAPACITIES
        #----------------------------------------------


        #change status of next Turn
        change_status(next_turn(@payment.turn), 'active')
      end
    end
    #change Status of Capacity to Pagado of User que pagó
    p = view_context.what_level(@payment.level_id, @payment.login)
    if change_status(p, 'pagado')
      logger.debug "Estatus de esta capacidad ha sido cambiado a 'pagado'"
    end

  end


    # Use callbacks to share common setup or constraints between actions.
    def set_payment
      @payment = Payment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def payment_params
      params[:payment]
    end

    def get_t_position
      Turn.find_by_status('active')
    end

  def permitir
    params.require(:payment).permit(:amount, :gateway, :turn_id, :level_id, :receipt)
  end

  def is_beneficiary?
    @payment = Payment.find(params[:id])

    if current_login.id == @payment.beneficiary_id
      return true
    else
      redirect_to root_path, alert: 'No tienes permisos para acceder a esta página'
    end
  end

  def is_sender?
    @payment = Payment.find(params[:id])

    if current_login.id == @payment.login_id
      return true
    else
      redirect_to root_path, alert: 'No tienes permisos para acceder a esta página'
    end
  end

end
