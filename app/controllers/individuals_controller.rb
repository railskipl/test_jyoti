class IndividualsController < ApplicationController
	respond_to :html, :js
  
 def index
 	 @individuals = Individual.all
 end


  def new
    @individual = Individual.new
   
  end
  
  def create
    @individual = Individual.new(params[:individual])
    if @individual.save
     redirect_to individuals_path
    else
      render 'new'
    end
  end

 def status
  @individual = Individual.find(params[:id])
  @individual.status = !@individual.status?
    @individual.save!
    redirect_to :back 
 end

  def edit
    @individual = Individual.find(params[:id])
  end

  def update
    @individual = Individual.find(params[:id])
    if @individual.update_attributes(params[:Individual])
       redirect_to individuals_path
    else
      render 'edit'
    end
  end

  def destroy
    @individual = Individual.find(params[:id])
    @individual.destroy
    redirect_to individuals_path
  end

  def indiv_path
    
  end

  def indiv2
    
  end

  def submit_indiv2
    @user = User.where('email = ?', params[:email])
    @gotfeedback = AccessReputationTip.where(:user_id => @user.first.id) rescue nil
    if @gotfeedback.first
      a = 1
      @gotfeedback.first.got_feedback = @gotfeedback.first.got_feedback + 1
      @gotfeedback.first.update_attributes(params[:access_reputation_tip])
    end

    if user_signed_in?
        #for onbording sequence give feedback to others
          @givefeedback = AccessReputationTip.where(:user_id => current_user.id)
            
          if @givefeedback.first
            a = 1 
            @givefeedback.first.give_feedback = @givefeedback.first.give_feedback + a
            @givefeedback.first.update_attributes(params[:access_reputation_tip])
          end
    end
    @praise = Praise.create(:email => params[:email], :praise_comment => params[:praise], :provider_user_id => params[:user_id],:typee => "praise")

    @criticism = Criticism.create(:email => params[:email], :criticism_comment => params[:criticism],:provider_user_id => params[:user_id], :typee => "criticism")

    @general = General.create(:email => params[:email], :general_comment => params[:helpful_tips],:provider_user_id => params[:user_id], :typee => "general")
    
    redirect_to indiv3_individuals_path
  end


  def submit_indiv3
    # @tip = Tip.create(:response => params[:response]) 
    redirect_to indiv4_individuals_path   
  end

  def submit_indiv4
    @ratingother = Ratingother.create(:user_id => current_user.id,:trustworthy => params[:trustworthy],:kind_helpful => params[:kind_helpful], :potential => params[:potential], :perform_well => params[:perform_well], :presentable => params[:presentable], :emotianally_mature => params[:emotianally_mature], :friendly_social => params[:friendly_social] )
    redirect_to indiv5_individuals_path 
  end

  def submit_indiv5
    @ratingother = Rating.create(:user_id => current_user.id,:trustworthy => params[:trustworthy],:kind_helpful => params[:kind_helpful], :potential => params[:potential], :perform_well => params[:perform_well], :presentable => params[:presentable], :emotianally_mature => params[:emotianally_mature], :friendly_social => params[:friendly_social] )
    redirect_to indiv6_individuals_path 
  end


  def indiv3
    @praise = Praise.where('provider_user_id != ?', current_user.id)
    @praises = Praise.where('email != ?', current_user.email)

    @criticism = Criticism.where('provider_user_id != ?', current_user.id)
    @criticisms = Criticism.where('email != ?', current_user.email)

    @general = General.where('provider_user_id != ?', current_user.id)
    @generals = General.where('email != ?', current_user.email)
    
    
    @second_priority1 = @praises.where('tip_accept = ? or tip_reject = ? and tip_viewed >= ?', 1, 1, 1 ).order("RANDOM()").first rescue nil
    @zero_priority1 = @praises.where('tip_accept = ? or tip_reject = ? and tip_viewed = ?', 0, 0, 0).order("RANDOM()").first rescue nil
    
    @second_priority2 = @criticisms.where('tip_accept = ? or tip_reject = ? and tip_viewed >= ? ', 1, 1, 1 ).order("RANDOM()").first rescue nil
    @zero_priority2 = @criticisms.where('tip_accept = ? or tip_reject = ? and tip_viewed = ?', 0, 0, 0).order("RANDOM()").first rescue nil
    
    @second_priority3 = @generals.where('tip_accept = ? or tip_reject = ? and tip_viewed >= ?', 1, 1, 1 ).order("RANDOM()").first rescue nil
    @zero_priority3 = @generals.where('tip_accept = ? or tip_reject = ? and tip_viewed = ?', 0, 0, 0).order("RANDOM()").first rescue nil
    
    h = [@second_priority1,@second_priority2,@second_priority3]
    @second_priority = h.shuffle.sample
    
    v = [@zero_priority1,@zero_priority2,@zero_priority3]
    @zero_priority = v.shuffle.sample

    if @second_priority.present?
      @priority = @second_priority
    else
      @priority = @zero_priority
    end
    @power = PowerGroup.where('email = ? and circle_name = ?', current_user.email, @priority.circle_name) rescue nil
    if @power.blank?
     @ww = @priority
    end
  end




  def indiv4
     @ratingother = Ratingother.new
  end

  def indiv5
    @ratings = Rating.new    
  end

  def indiv6
    
  end

  def indiv7
    
  end


end



