class SponseeApprovalsController < ApplicationController
  before_action :set_sponsee_approval, only: [:show, :edit, :update, :destroy]

  # GET /sponsee_approvals
  # GET /sponsee_approvals.json
  def index
    @sponsee_approvals = SponseeApproval.all
  end

  # GET /sponsee_approvals/1
  # GET /sponsee_approvals/1.json
  def show
  end

  # GET /sponsee_approvals/new
  def new
    @sponsee_approval = SponseeApproval.new
  end

  # GET /sponsee_approvals/1/edit
  def edit
  end

  # POST /sponsee_approvals
  # POST /sponsee_approvals.json
  def create
    @sponsee_approval = SponseeApproval.new(sponsee_approval_params)

    respond_to do |format|
      if @sponsee_approval.save
        format.html { redirect_to @sponsee_approval, notice: 'Sponsee approval was successfully created.' }
        format.json { render :show, status: :created, location: @sponsee_approval }
      else
        format.html { render :new }
        format.json { render json: @sponsee_approval.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sponsee_approvals/1
  # PATCH/PUT /sponsee_approvals/1.json
  def update
    respond_to do |format|
      if @sponsee_approval.update(sponsee_approval_params)
        format.html { redirect_to @sponsee_approval, notice: 'Sponsee approval was successfully updated.' }
        format.json { render :show, status: :ok, location: @sponsee_approval }
      else
        format.html { render :edit }
        format.json { render json: @sponsee_approval.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sponsee_approvals/1
  # DELETE /sponsee_approvals/1.json
  def destroy
    @sponsee_approval.destroy
    respond_to do |format|
      format.html { redirect_to sponsee_approvals_url, notice: 'Sponsee approval was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sponsee_approval
      @sponsee_approval = SponseeApproval.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sponsee_approval_params
      params.require(:sponsee_approval).permit(:approve_custom_factor, :custom_factor, :your_choise_custom_factor)
    end
end
