class RelationshipsController < ApplicationController
  before_action :set_relationship, only: [:show, :edit, :update, :destroy]

  # GET /relationships
  # GET /relationships.json
  def index
    @relationships = Relationship.all
  end

  # GET /relationships/1
  # GET /relationships/1.json
  def show
  end

  # GET /relationships/new
  def new
    @relationship = Relationship.new
  end

  def cal
    @relationships = Relationship.all

  end

  # GET /relationships/1/edit
  def edit
  end

  # POST /relationships
  # POST /relationships.json
  def create
   @relationship = Relationship.new(relationship_params)

   @y = @relationship.know_how_for_long_year
   @m = @relationship.know_how_for_long_month 
   @month = @y*12
   @total_month = (@month)+(@m)
   @how_long_you_know_each_other_avg = (@total_month*20)/36  
   @relationship.how_long_you_know_each_other_avg =  @how_long_you_know_each_other_avg
   
   @p = @relationship.how_well_you_know_the_person.to_i
   @h = (@p)*20
   @well_known_user_avg = @h/8
   @relationship.well_known_user_avg = @well_known_user_avg

   @i = @relationship.your_influence.to_i
   @influence = (@i)*60
   @influence_avg = @influence/8
   @relationship.influence_avg = @influence_avg
   
   # @a = Relationship.all
   # if @b = @a.count >= 8 && @a.count <= 20
   #   @power_group = PowerGroup.new(:user_id => current_user.id,:email => @relationship.email)
   #   @power_group.save!
   # end


    respond_to do |format|
      if @relationship.save
         # FeedbackMailer.relationship_feedback(@relationship).deliver
        format.html { redirect_to @relationship, notice: 'Relationship was successfully created.' }
        format.json { render :show, status: :created, location: @relationship }
      else
        format.html { render :new }
        format.json { render json: @relationship.errors, status: :unprocessable_entity }
      end
    end
  end

  

  # PATCH/PUT /relationships/1
  # PATCH/PUT /relationships/1.json
  def update
    respond_to do |format|
      if @relationship.update(relationship_params)
        format.html { redirect_to @relationship, notice: 'Relationship was successfully updated.' }
        format.json { render :show, status: :ok, location: @relationship }
      else
        format.html { render :edit }
        format.json { render json: @relationship.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /relationships/1
  # DELETE /relationships/1.json
  def destroy
    @relationship.destroy
    respond_to do |format|
      format.html { redirect_to relationships_url, notice: 'Relationship was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def add_power_group
    relationship_ids = params["relationship_ids"]
    @relationships ||= []
    # @relationships = Relationship.where("user_id = ? " ,current_user.id)
    relationship_ids.to_a.each do |r|
    @relationships << Relationship.find(r)
    u = PowerGroup.new( :user_id => current_user.id)
    u.save!
  end 

  end

  
  

  def power_group
    @relationships = Relationship.find(params[:relationship_id])

    # @users = params[:emails]
    if request.post?
      # @relationships = Relationship.where("user_id = ? " ,current_user.id)
        u = PowerGroup.new( :user_id => current_user.id, :email => email )
        u.save!
      end  
      redirect_to relationships_path, :notice => "Add in Power Group successfully"
  end




  private
    # Use callbacks to share common setup or constraints between actions.
    def set_relationship
      @relationship = Relationship.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def relationship_params
      params.require(:relationship).permit(:email, :know_how_for_long_year, :know_how_for_long_month, :how_well_you_know_the_person, :your_influence, :influence_on_your, :user_id,:well_known_user_avg,:influence_avg,:how_long_you_know_each_other_avg,:custom_factor,:name,:circle_id,:good_coach,:empowers_team,:expresses_interest_concern,:productive_results_oriented,:good_communicator,:helps_with_career_development,:clear_vision_and_strategy,:uses_special_skills_to_advise,:romantic,:approve_custom_factor,:your_choise_custom_factor)
    end
end