class FeedbacksController < ApplicationController
  before_action :set_feedback, only: [:show, :edit, :update, :destroy]
  before_filter :check_user, only: [:index,:destroy]

  # GET /feedbacks
  # GET /feedbacks.json
  def index
    @feedbacks = Feedback.all
  end

  # GET /feedbacks/1
  # GET /feedbacks/1.json
  def show
  end

  # GET /feedbacks/new
  def new
    @feedback = Feedback.new
  end

  # GET /feedbacks/1/edit
  def edit
  end

  # POST /feedbacks
  # POST /feedbacks.json
  def create
    @feedback = Feedback.new(feedback_params)
    email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/
    email = @feedback.email =~ email_regex
    if email == 0
      respond_to do |format|
        if @feedback.save
          FeedbackMailer.feedback_mailer(@feedback).deliver
          format.html { redirect_to  root_path, notice: 'Thanking for your Valuable Feeedback.' }
          format.json { render :show, status: :created, location: @feedback }
        else
          format.html { render :new }
          format.json { render json: @feedback.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to root_path, :notice => "Please Enter Valid Email"
    end
  end

  # PATCH/PUT /feedbacks/1
  # PATCH/PUT /feedbacks/1.json
  def update
    respond_to do |format|
      if @feedback.update(feedback_params)
        format.html { redirect_to @feedback, notice: 'Feedback was successfully updated.' }
        format.json { render :show, status: :ok, location: @feedback }
      else
        format.html { render :edit }
        format.json { render json: @feedback.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /feedbacks/1
  # DELETE /feedbacks/1.json
  def destroy
    @feedback.destroy
    respond_to do |format|
      format.html { redirect_to feedbacks_url, notice: 'Feedback was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_feedback
      @feedback = Feedback.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def feedback_params
      params.require(:feedback).permit(:name, :email, :description)
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
