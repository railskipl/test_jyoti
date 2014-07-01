class TrialDaysController < ApplicationController
  before_action :set_trial_day, only: [:show, :edit, :update, :destroy]

  # GET /trial_days
  # GET /trial_days.json
  def index
    @trial_days = TrialDay.all
  end

  # GET /trial_days/1
  # GET /trial_days/1.json
  def show
  end

  # GET /trial_days/new
  def new
    @trial_day = TrialDay.new
  end

  # GET /trial_days/1/edit
  def edit
  end

  # POST /trial_days
  # POST /trial_days.json
  def create
    @trial_day = TrialDay.new(trial_day_params)

    respond_to do |format|
      if @trial_day.save
        format.html { redirect_to @trial_day, notice: 'Trial day was successfully created.' }
        format.json { render :show, status: :created, location: @trial_day }
      else
        format.html { render :new }
        format.json { render json: @trial_day.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /trial_days/1
  # PATCH/PUT /trial_days/1.json
  def update
    respond_to do |format|
      if @trial_day.update(trial_day_params)
        format.html { redirect_to @trial_day, notice: 'Trial day was successfully updated.' }
        format.json { render :show, status: :ok, location: @trial_day }
      else
        format.html { render :edit }
        format.json { render json: @trial_day.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /trial_days/1
  # DELETE /trial_days/1.json
  def destroy
    @trial_day.destroy
    respond_to do |format|
      format.html { redirect_to trial_days_url, notice: 'Trial day was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_trial_day
      @trial_day = TrialDay.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def trial_day_params
      params.require(:trial_day).permit(:days)
    end
end
