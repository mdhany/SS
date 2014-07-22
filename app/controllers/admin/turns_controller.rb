class Admin::TurnsController < ApplicationController
  before_action :authenticate_manager!
  before_action :set_admin_turn, only: [:show, :edit, :update, :destroy]

  # GET /admin/turns
  # GET /admin/turns.json
  def index
    @turns = Turn.where level_id: 1
    @turns2 = Turn.where level_id: 2
    @turns3 = Turn.where level_id: 3

    @ttotal = Turn.count
  end

  # GET /admin/turns/1
  # GET /admin/turns/1.json
  def show
  end

  # GET /admin/turns/new
  def new
    @turn = Turn.new
  end

  # GET /admin/turns/1/edit
  def edit
  end

  # POST /admin/turns
  # POST /admin/turns.json
  def create
    @turn = Turn.new(admin_turn_params)

    respond_to do |format|
      if @turn.save
        #changes STATUS
        c = view_context.what_level(@turn.level_id, @turn.login)
        c.update_attribute :status, 'active'
        change_status @turn.login, 'active'
        #FIN changes STATUS

        format.html { redirect_to admin_turn_path(@turn), notice: 'Turn was successfully created.' }
        format.json { render :show, status: :created, location: @turn }
      else
        format.html { render :new }
        format.json { render json: @turn.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/turns/1
  # PATCH/PUT /admin/turns/1.json
  def update
    respond_to do |format|
      if @turn.update(admin_turn_params)
        format.html { redirect_to admin_turn_path(@turn), notice: 'Turn was successfully updated.' }
        format.json { render :show, status: :ok, location: @turn }
      else
        format.html { render :edit }
        format.json { render json: @turn.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/turns/1
  # DELETE /admin/turns/1.json
  def destroy
    @turn.destroy
    respond_to do |format|
      format.html { redirect_to admin_turns_url, notice: 'Turn was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_turn
      @turn = Turn.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_turn_params
      params.require(:turn).permit(:login_id, :level_id, :status)
    end
end
