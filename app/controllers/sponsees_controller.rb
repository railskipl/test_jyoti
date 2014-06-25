class SponseesController < ApplicationController
  before_action :set_sponsee, only: [:show, :edit, :update, :destroy]
  before_filter :check_user, only: [:index,:destroy,:edit,:update,:new]

  # GET /sponsees
  # GET /sponsees.json
  def index
    @sponsees = Sponsee.all
  end

  # GET /sponsees/1
  # GET /sponsees/1.json
  def show
  end

  # GET /sponsees/new
  def new
    @sponsee = Sponsee.new
  end

  # GET /sponsees/1/edit
  def edit
  end

  # POST /sponsees
  # POST /sponsees.json
  def create
    @sponsee = Sponsee.new(sponsee_params)
    
    respond_to do |format|
      if @sponsee.save
        format.html { redirect_to @sponsee, notice: 'Sponsee was successfully created.' }
        format.json { render :show, status: :created, location: @sponsee }
      else
        format.html { render :new }
        format.json { render json: @sponsee.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sponsees/1
  # PATCH/PUT /sponsees/1.json
  def update
    respond_to do |format|
      if @sponsee.update(sponsee_params)
        format.html { redirect_to @sponsee, notice: 'Sponsee was successfully updated.' }
        format.json { render :show, status: :ok, location: @sponsee }
      else
        format.html { render :edit }
        format.json { render json: @sponsee.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sponsees/1
  # DELETE /sponsees/1.json
  def destroy
    @sponsee.destroy
    respond_to do |format|
      format.html { redirect_to sponsees_url, notice: 'Sponsee was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sponsee
      @sponsee = Sponsee.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sponsee_params
      params.require(:sponsee).permit(:user_id, :relationship_id, :email, :approve_admin_custom_factor, :your_choise_custom_factor,:custom_factor,:name)
    end

    def check_user
      if user_signed_in?
        else
        redirect_to root_path, :alert => "Unauthorised Access"
      end     
    end
end
