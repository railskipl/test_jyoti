class InfluencesController < ApplicationController
  before_action :set_influence, only: [:show, :edit, :update, :destroy]
  before_filter :check_user, only: [:index,:destroy,:edit,:update,:new]


  # GET /influences
  # GET /influences.json
  def index
    @influences = Influence.all
    @user_invitations = UserInvitation.find_by_user_id(current_user)
  end

  # GET /influences/1
  # GET /influences/1.json
  def show
  end

  # GET /influences/new
  def new
    @influence = Influence.new
    3.times do
      @influence.power_groups.build
    end
  end

  # GET /influences/1/edit
  def edit
  end

  # POST /influences
  # POST /influences.json
  def create
    @influence = Influence.new(influence_params)

    respond_to do |format|
      if @influence.save
        format.html { redirect_to new_influence_path, notice: 'Influence was successfully created.' }
        format.json { render :show, status: :created, location: @influence }
      else
        format.html { render :new }
        format.json { render json: @influence.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /influences/1
  # PATCH/PUT /influences/1.json
  def update
    respond_to do |format|
      if @influence.update(influence_params)
        format.html { redirect_to @influence, notice: 'Influence was successfully updated.' }
        format.json { render :show, status: :ok, location: @influence }
      else
        format.html { render :edit }
        format.json { render json: @influence.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /influences/1
  # DELETE /influences/1.json
  def destroy
    @influence.destroy
    respond_to do |format|
      format.html { redirect_to influences_url, notice: 'Influence was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_influence
      @influence = Influence.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def influence_params
      params.require(:influence).permit(:user_id,:your_influence, :influence_on_your, :email,power_groups_attributes: [:email,:influence_on_your,:your_influence,:influence_id,:user_id])
    end

    def check_user
      if user_signed_in?
        else
        redirect_to root_path, :alert => "Unauthorised Access"
      end
     
    end
end
