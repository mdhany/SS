class Admin::LevelsController < ApplicationController
  before_action :authenticate_manager!
  before_action :set_admin_level, only: [:show, :edit, :update, :destroy]

  # GET /admin/levels
  # GET /admin/levels.json
  def index
    @admin_levels = Admin::Level.all
  end

  # GET /admin/levels/1
  # GET /admin/levels/1.json
  def show
  end

  # GET /admin/levels/new
  def new
    @admin_level = Admin::Level.new
  end

  # GET /admin/levels/1/edit
  def edit
  end

  # POST /admin/levels
  # POST /admin/levels.json
  def create
    @admin_level = Admin::Level.new(admin_level_params)

    respond_to do |format|
      if @admin_level.save
        format.html { redirect_to edit_admin_level_path(@admin_level), notice: 'Level was successfully created.' }
        format.json { render :show, status: :created, location: @admin_level }
      else
        format.html { render :new }
        format.json { render json: @admin_level.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/levels/1
  # PATCH/PUT /admin/levels/1.json
  def update
    respond_to do |format|
      if @admin_level.update(admin_level_params)
        format.html { redirect_to edit_admin_level_path(@admin_level), notice: 'Level was successfully updated.' }
        format.json { render :show, status: :ok, location: @admin_level }
      else
        format.html { render :edit }
        format.json { render json: @admin_level.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/levels/1
  # DELETE /admin/levels/1.json
  def destroy
    @admin_level.destroy
    respond_to do |format|
      format.html { redirect_to admin_levels_url, notice: 'Level was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_level
      @admin_level = Admin::Level.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_level_params
      params.require(:admin_level).permit(:name, :description, :amount)
    end
end
