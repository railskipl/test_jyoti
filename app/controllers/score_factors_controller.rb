class ScoreFactorsController < ApplicationController
  before_action :set_score_factor, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!
  
  # GET /score_factors
  # GET /score_factors.json
  def index
    @score_factors = ScoreFactor.all
  end

  # GET /score_factors/1
  # GET /score_factors/1.json
  def show
  end

  # GET /score_factors/new
  def new
    @score_factor = ScoreFactor.new
  end

  # GET /score_factors/1/edit
  def edit
  end

  # POST /score_factors
  # POST /score_factors.json
  def create
    @score_factor = ScoreFactor.new(score_factor_params)

    respond_to do |format|
      if @score_factor.save
        format.html { redirect_to score_factors_url, notice: 'Score factor was successfully created.' }
        format.json { render :show, status: :created, location: @score_factor }
      else
        format.html { render :new }
        format.json { render json: @score_factor.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /score_factors/1
  # PATCH/PUT /score_factors/1.json
  def update
    respond_to do |format|
      if @score_factor.update(score_factor_params)
        format.html { redirect_to score_factors_url, notice: 'Score factor was successfully updated.' }
        format.json { render :show, status: :ok, location: @score_factor }
      else
        format.html { render :edit }
        format.json { render json: @score_factor.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /score_factors/1
  # DELETE /score_factors/1.json
  def destroy
    @score_factor.destroy
    respond_to do |format|
      format.html { redirect_to score_factors_url, notice: 'Score factor was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_score_factor
      @score_factor = ScoreFactor.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def score_factor_params
      params.require(:score_factor).permit(:name, :description,:factor_type)
    end
end
