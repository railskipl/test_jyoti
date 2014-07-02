class ResponseTipsController < ApplicationController
  before_action :set_response_tip, only: [:show, :edit, :update, :destroy]

  # GET /response_tips
  # GET /response_tips.json
  def index
    @response_tips = ResponseTip.all
    @tip = Tip.all
  end

  # GET /response_tips/1
  # GET /response_tips/1.json
  def show
  end

  # GET /response_tips/new
  def new
    @response_tip = ResponseTip.new
  end

  # GET /response_tips/1/edit
  def edit
  end

  # POST /response_tips
  # POST /response_tips.json
  def create
    @response_tip = ResponseTip.new(response_tip_params)
    
    respond_to do |format|
      if @response_tip.save
        format.html { redirect_to my_mirror_paste_users_path, notice: 'Response tip was successfully created.' }
        format.json { render :show, status: :created, location: @response_tip }
      else
        format.html { render :new }
        format.json { render json: @response_tip.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /response_tips/1
  # PATCH/PUT /response_tips/1.json
  def update
    respond_to do |format|
      if @response_tip.update(response_tip_params)
        format.html { redirect_to @response_tip, notice: 'Response tip was successfully updated.' }
        format.json { render :show, status: :ok, location: @response_tip }
      else
        format.html { render :edit }
        format.json { render json: @response_tip.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /response_tips/1
  # DELETE /response_tips/1.json
  def destroy
    @response_tip.destroy
    respond_to do |format|
      format.html { redirect_to response_tips_url, notice: 'Response tip was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_response_tip
      @response_tip = ResponseTip.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def response_tip_params
      params.require(:response_tip).permit(:tip_id, :response_for_tip, :tag_tip, :user_id)
    end
end
