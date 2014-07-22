class Admin::PaymentsController < ApplicationController
  before_action :authenticate_manager!
  before_action :set_admin_payment, only: [:show, :edit, :update, :destroy]

  # GET /admin/payments
  # GET /admin/payments.json
  def index
    @admin_payments = Admin::Payment.all
  end

  # GET /admin/payments/1
  # GET /admin/payments/1.json
  def show
  end

  # GET /admin/payments/new
  def new
    @admin_payment = Admin::Payment.new
  end

  # GET /admin/payments/1/edit
  def edit
  end

  # POST /admin/payments
  # POST /admin/payments.json
  def create
    @admin_payment = Admin::Payment.new(admin_payment_params)

    respond_to do |format|
      if @admin_payment.save
        format.html { redirect_to admin_payments_path, notice: 'Payment was successfully created.' }
        format.json { render :show, status: :created, location: @admin_payment }
      else
        format.html { render :new }
        format.json { render json: @admin_payment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/payments/1
  # PATCH/PUT /admin/payments/1.json
  def update
    respond_to do |format|
      if @admin_payment.update(admin_payment_params)
        format.html { redirect_to edit_admin_payment_path(@admin_payment), notice: 'Payment was successfully updated.' }
        format.json { render :show, status: :ok, location: @admin_payment }
      else
        format.html { render :edit }
        format.json { render json: @admin_payment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/payments/1
  # DELETE /admin/payments/1.json
  def destroy
    @admin_payment.destroy
    respond_to do |format|
      format.html { redirect_to admin_payments_url, notice: 'Payment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_payment
      @admin_payment = Admin::Payment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_payment_params
      params.require(:admin_payment).permit(:amount, :turn_id, :sent, :received, :gateway, :level_id, :login_id, :beneficiary_id)
    end
end
