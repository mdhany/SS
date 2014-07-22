class Admin::CapacitiesController < ApplicationController
  before_action :authenticate_manager!
  before_action :set_admin_capacity, only: [:show, :edit, :update, :destroy]

  # GET /admin/capacities
  # GET /admin/capacities.json
  def index
    @admin_capacities = Capacity.all
  end

  # GET /admin/capacities/1
  # GET /admin/capacities/1.json
  def show
  end

  # GET /admin/capacities/new
  def new
    @admin_capacity = Capacity.new
  end

  # GET /admin/capacities/1/edit
  def edit
  end

  # POST /admin/capacities
  # POST /admin/capacities.json
  def create
    @admin_capacity = Capacity.new(admin_capacity_params)

    respond_to do |format|
      if @admin_capacity.save
        format.html { redirect_to admin_capacity_path(@admin_capacity), notice: 'Capacidad fue creada.' }
        format.json { render :show, status: :created, location: @admin_capacity }
      else
        format.html { render :new }
        format.json { render json: @admin_capacity.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/capacities/1
  # PATCH/PUT /admin/capacities/1.json
  def update
    respond_to do |format|
      if @admin_capacity.update(admin_capacity_params)
        format.html { redirect_to admin_capacity_path(@admin_capacity), notice: 'Capacity was successfully updated.' }
        format.json { render :show, status: :ok, location: @admin_capacity }
      else
        format.html { render :edit }
        format.json { render json: @admin_capacity.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/capacities/1
  # DELETE /admin/capacities/1.json
  def destroy
    @admin_capacity.destroy
    respond_to do |format|
      format.html { redirect_to admin_capacities_url, notice: 'Capacity was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_capacity
      @admin_capacity = Capacity.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_capacity_params
      params.require(:admin_capacity).permit(:name, :status, :capacity, :level_id, :login_id)
    end
end
