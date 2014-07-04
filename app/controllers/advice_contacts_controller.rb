class AdviceContactsController < ApplicationController
  before_action :set_advice_contact, only: [:show, :edit, :update, :destroy]

  # GET /advice_contacts
  # GET /advice_contacts.json
  def index
    @advice_contacts = AdviceContact.all
    @tip = Tip.all
  end

  # GET /advice_contacts/1
  # GET /advice_contacts/1.json
  def show
  end

  # GET /advice_contacts/new
  def new
    @advice_contact = AdviceContact.new
  end

  # GET /advice_contacts/1/edit
  # def edit
  # end

  # POST /advice_contacts
  # POST /advice_contacts.json
  def create
    @advice_contact = AdviceContact.new(advice_contact_params)
    advice_contact = @advice_contact
    contact = Contact.where("email like ?",@advice_contact.email).first_or_create

    respond_to do |format|
      if @advice_contact.save
        @tip = Tip.new(:email => @advice_contact.email, :praise => @advice_contact.praise, :criticism => @advice_contact.criticism, :helpful => @advice_contact.helpful_tips)
        @tip.save!
        Mailer.prelogin_tips(advice_contact).deliver
        format.html { redirect_to new_ratingother_path(:email => @advice_contact.email), notice: 'Data send successfully.' }
        format.json { render :show, status: :created, location: @advice_contact }
      else
        format.html { render :new }
        format.json { render json: @advice_contact.errors, status: :unprocessable_entity }
      end
    end
  end

  def post_login
    @contacts = Contact.where("user_id = ?",current_user.id)
  end


  def destroy
    @advice_contact = AdviceContact.find(params[:id])
    @advice_contact.destroy
    redirect_to advice_contacts_path
  end

  # PATCH/PUT /advice_contacts/1
  # PATCH/PUT /advice_contacts/1.json
  # def update
  #   respond_to do |format|
  #     if @advice_contact.update(advice_contact_params)
  #       format.html { redirect_to @advice_contact, notice: 'Advice contact was successfully updated.' }
  #       format.json { render :show, status: :ok, location: @advice_contact }
  #     else
  #       format.html { render :edit }
  #       format.json { render json: @advice_contact.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # # DELETE /advice_contacts/1
  # # DELETE /advice_contacts/1.json
  # def destroy
  #   @advice_contact.destroy
  #   respond_to do |format|
  #     format.html { redirect_to advice_contacts_url, notice: 'Advice contact was successfully destroyed.' }
  #     format.json { head :no_content }
  #   end
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_advice_contact
      @advice_contact = AdviceContact.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def advice_contact_params
      params.require(:advice_contact).permit(:email, :praise, :criticism, :helpful_tips,:user_id)
    end
end
