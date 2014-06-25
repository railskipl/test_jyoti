class SponsersController < ApplicationController
  before_action :set_sponser, only: [:show, :edit, :update, :destroy]
  before_filter :check_user, only: [:index,:destroy,:edit,:update,:new]

  # GET /sponsers
  # GET /sponsers.json
  def index
    @sponsers = Sponser.all
  end

  # GET /sponsers/1
  # GET /sponsers/1.json
  def show
  end

  # GET /sponsers/new
  def new
    @sponser = Sponser.new
    1.times do
      @sponser.sponsercfs.build
    end
  end

  # GET /sponsers/1/edit
  def edit
  end

  # POST /sponsers
  # POST /sponsers.json
  def create
    @sponser = Sponser.new(sponser_params)

    respond_to do |format|
      if @sponser.save
        format.html { redirect_to @sponser, notice: 'Sponser was successfully created.' }
        format.json { render :show, status: :created, location: @sponser }
      else
        format.html { render :new }
        format.json { render json: @sponser.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sponsers/1
  # PATCH/PUT /sponsers/1.json
  def update
    respond_to do |format|
      if @sponser.update(sponser_params)
        format.html { redirect_to @sponser, notice: 'Sponser was successfully updated.' }
        format.json { render :show, status: :ok, location: @sponser }
      else
        format.html { render :edit }
        format.json { render json: @sponser.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sponsers/1
  # DELETE /sponsers/1.json
  def destroy
    @sponser.destroy
    respond_to do |format|
      format.html { redirect_to sponsers_url, notice: 'Sponser was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sponser
      @sponser = Sponser.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sponser_params
      params.require(:sponser).permit(:name, :custom_factor,:user_id,sponsercfs_attributes: [:name,:custom_factor,:user_id])
    end

    def check_user
      if user_signed_in?
        else
        redirect_to root_path, :alert => "Unauthorised Access"
      end     
    end
    
end
