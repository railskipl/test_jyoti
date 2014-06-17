class FactorsController < ApplicationController
  before_action :set_factor, only: [:show, :edit, :update, :destroy]
  before_filter :check_user, only: [:index,:destroy,:edit,:update,:new]


  # GET /factors
  # GET /factors.json
  def index
    @factors = Factor.all
  end

  # GET /factors/1
  # GET /factors/1.json
  def show
  end

  # GET /factors/new
  def new
    @factor = Factor.new
  end

  # GET /factors/1/edit
  def edit
  end

  # POST /factors
  # POST /factors.json
  def create
    @factor = Factor.new(factor_params)

    respond_to do |format|
      if @factor.save
        format.html { redirect_to factors_path, notice: 'Factor was successfully created.' }
        format.json { render :show, status: :created, location: @factor }
      else
        format.html { render :new }
        format.json { render json: @factor.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /factors/1
  # PATCH/PUT /factors/1.json
  def update
    respond_to do |format|
      if @factor.update(factor_params)
        format.html { redirect_to factors_path, notice: 'Factor was successfully updated.' }
        format.json { render :show, status: :ok, location: @factor }
      else
        format.html { render :edit }
        format.json { render json: @factor.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /factors/1
  # DELETE /factors/1.json
  def destroy
    @factor.destroy
    respond_to do |format|
      format.html { redirect_to factors_url, notice: 'Factor was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_factor
      @factor = Factor.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def factor_params
      params.require(:factor).permit(:name, :circle_id)
    end


    def check_user
      if user_signed_in?
        if current_user.is_admin?
        else
          redirect_to root_path, :alert => "Unauthorised Access"
        end
      else 
        redirect_to root_path, :alert => "Unauthorised Access"
      end
    end
end
