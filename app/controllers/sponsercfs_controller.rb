class SponsercfsController < ApplicationController
  before_action :set_sponsercf, only: [:show, :edit, :update, :destroy]
  before_filter :check_user, only: [:index,:destroy,:edit,:update,:new]

  # GET /sponsercfs
  # GET /sponsercfs.json
  def index
    @sponsercfs = Sponsercf.all
  end

  # GET /sponsercfs/1
  # GET /sponsercfs/1.json
  def show
  end

  # GET /sponsercfs/new
  def new
    @sponsercf = Sponsercf.new
  end

  # GET /sponsercfs/1/edit
  def edit
  end

  # POST /sponsercfs
  # POST /sponsercfs.json
  def create
    @sponsercf = Sponsercf.new(sponsercf_params)

    respond_to do |format|
      if @sponsercf.save
        
        format.html { redirect_to @sponsercf, notice: 'Sponsercf was successfully created.' }
        format.json { render :show, status: :created, location: @sponsercf }
      else
        format.html { render :new }
        format.json { render json: @sponsercf.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sponsercfs/1
  # PATCH/PUT /sponsercfs/1.json
  def update
    respond_to do |format|
      if @sponsercf.update(sponsercf_params)
        format.html { redirect_to @sponsercf, notice: 'Sponsercf was successfully updated.' }
        format.json { render :show, status: :ok, location: @sponsercf }
      else
        format.html { render :edit }
        format.json { render json: @sponsercf.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sponsercfs/1
  # DELETE /sponsercfs/1.json
  def destroy
    @sponsercf.destroy
    respond_to do |format|
      format.html { redirect_to sponsercfs_url, notice: 'Sponsercf was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sponsercf
      @sponsercf = Sponsercf.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sponsercf_params
      params.require(:sponsercf).permit(:sponser_id, :user_id, :name, :custom_factor_string, :email)
    end

    def check_user
      if user_signed_in?
        else
        redirect_to root_path, :alert => "Unauthorised Access"
      end     
    end
end
