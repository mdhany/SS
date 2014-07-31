class Admin::LoginsController < ApplicationController
  before_action :authenticate_manager!
  before_action :set_admin_login, only: [:show, :edit, :update, :destroy]

  # GET /admin/logins
  # GET /admin/logins.json
  def index
    @admin_logins = Login.all
  end

  # GET /admin/logins/1
  # GET /admin/logins/1.json
  def show
  end

  # GET /admin/logins/new
  def new
    @admin_login = Login.new
  end

  # GET /admin/logins/1/edit
  def edit
    @sponsor = @admin_login.sponsor.username
  end

  # POST /admin/logins
  # POST /admin/logins.json
  def create
    @admin_login = Login.new(admin_login_params)

    respond_to do |format|
      if @admin_login.save
        format.html { redirect_to admin_login_path(@admin_login), notice: 'Login was successfully created.' }
        format.json { render :show, status: :created, location: @admin_login }
      else
        format.html { render :new }
        format.json { render json: @admin_login.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/logins/1
  # PATCH/PUT /admin/logins/1.json
  def update
    respond_to do |format|
      if @admin_login.update(admin_login_params)
        format.html { redirect_to admin_login_path(@admin_login), notice: 'Login was successfully updated.' }
        format.json { render :show, status: :ok, location: @admin_login }
      else
        format.html { render :edit }
        format.json { render json: @admin_login.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/logins/1
  # DELETE /admin/logins/1.json
  def destroy
    @admin_login.destroy
    respond_to do |format|
      format.html { redirect_to admin_logins_url, notice: 'Login was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def change_used
    if params[:value] == "0"
      v = false
    else
      v = true
    end

    if change_login_used(params[:id], v)
      redirect_to admin_logins_url, notice: 'Usuario Fue Actualizado'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_login
      @admin_login = Login.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_login_params
      params[:admin_login]
    end
end
