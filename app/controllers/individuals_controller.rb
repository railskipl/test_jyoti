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
    @user = User.where('email = ?', params[:email]) rescue nil
    if @user.present?
      @gotfeedback = AccessReputationTip.where('user_id = ?', @user.first.id) rescue nil
      if @gotfeedback.present?
        a = 1
        @gotfeedback.first.got_feedback = @gotfeedback.first.got_feedback + 1
        @gotfeedback.first.update_attributes(params[:access_reputation_tip])
      else
        AccessReputationTip.create(:user_id => @user.first.id)
        @gotfeedback = AccessReputationTip.where('user_id = ?', @user.first.id) rescue nil
        if @gotfeedback.present?
          a = 1
          @gotfeedback.first.got_feedback = @gotfeedback.first.got_feedback + 1
          @gotfeedback.first.update_attributes(params[:access_reputation_tip])
        end
      end
    end

    if params[:praise].present? && params[:criticism].present? || params[:praise].present? && params[:general].present? || params[:criticism].present? && params[:general].present?
      if user_signed_in?
        #for onbording sequence give feedback to others
        @givefeedback = AccessReputationTip.where('user_id = ?', current_user.id) 
        if @givefeedback
          a = 1 
          @givefeedback.first.give_feedback = @givefeedback.first.give_feedback + a
          @givefeedback.first.update_attributes(params[:access_reputation_tip])
        end
      end

      if params[:praise]
        @praise = Praise.create(:email => params[:email], :praise_comment => params[:praise], :provider_user_id => params[:user_id],:typee => "praise")
      end

      if params[:criticism]
        @criticism = Criticism.create(:email => params[:email], :criticism_comment => params[:criticism],:provider_user_id => params[:user_id], :typee => "criticism")
      end

      if params[:general]
        @general = General.create(:email => params[:email], :general_comment => params[:helpful_tips],:provider_user_id => params[:user_id], :typee => "general")
      end

      redirect_to indiv3_individuals_path(:email => params[:email]), notice: "Tips has been provided to this particular user." 
    else
      redirect_to :back
      flash[:notice] = 'Please Give atleast Two tips'
    end
  end


  def submit_indiv3
     # raise indiv3.email.inspect
     if params[:typee] == "praise"
         @tip = Praise.find(params[:id])
     elsif params[:typee] == "criticism"
         @tip = Criticism.find(params[:id])
     else  params[:typee] == "general"
       @tip = General.find(params[:id])
     end

     sum = 1
    user_view = 1
    #logic for decidind the tip is helpful or not
    if @tip.tip_accept = 2
      @w = 1           #for deciding helpful tip
    elsif @tip.tip_reject = 2 
      @w = 2          #for deciding unhelpful tip
    else 
      @w = 0
    end
   
    if params[:response] == "true"
      @sum = @tip.tip_accept + sum
      @tip.tip_accept = @sum
    else
      @sum = @tip.tip_reject + sum
      @tip.tip_reject = @sum
    end
    @tip.tip_prediction = @w
    @tip.tip_viewed = @tip.tip_viewed + user_view
    if params[:typee] == "praise"
         @tip.update_attributes(params[:praise])
      elsif params[:typee] == "criticism"
         @tip.update_attributes(params[:criticism])
      else  params[:typee] == "general"
       @tip.update_attributes(params[:general])
      end
      #for onbording sequence quality check
      @quality_check = AccessReputationTip.where('user_id = ?', current_user.id)
      if @quality_check
        a = 1
        @quality_check.first.vote_on_tips = @quality_check.first.vote_on_tips + a
        @aa = @quality_check.first.update_attributes(params[:access_reputation_tip])
      end
    flash[:notice] = "Vote on tips provided."
    redirect_to indiv4_individuals_path(:email => indiv3.email, :user_id => current_user.id)

     # @tip = Tip.create(:response => params[:response]) 
       
  end



  def submit_indiv4
    #for onbording sequence ratings other
        if user_signed_in?
          @reputation = AccessReputationTip.where('user_id = ?', current_user.id)
          if @reputation
            a = 1
            @reputation.first.give_ratings = @reputation.first.give_ratings + 1
            @reputation.first.update_attributes(params[:access_reputation_tip])
          end
        end
    @ratingother = Ratingother.create(:email => params[:email],:user_id => current_user.id,:trustworthy => params[:trustworthy],:kind_helpful => params[:kind_helpful], :potential => params[:potential], :perform_well => params[:perform_well], :presentable => params[:presentable], :emotianally_mature => params[:emotianally_mature], :friendly_social => params[:friendly_social] )
    redirect_to indiv5_individuals_path, notice: "Rating has been done." 
  end

  def submit_indiv5
    #for onbording sequence selfimage
     @selfimage = AccessReputationTip.where('user_id = ?', current_user.id)
     a = 1
     if @selfimage
       @selfimage.first.give_selfimage = @selfimage.first.give_selfimage + a
       @selfimage.first.update_attributes(params[:access_reputation_tip])
     end 
    @rating = Rating.create(:user_id => current_user.id,:trustworthy => params[:trustworthy],:kind_helpful => params[:kind_helpful], :potential => params[:potential], :perform_well => params[:perform_well], :presentable => params[:presentable], :emotianally_mature => params[:emotianally_mature], :friendly_social => params[:friendly_social] )
    redirect_to indiv6_individuals_path, notice: "Rating has been done." 
  end


  def indiv3
    @praise = Praise.where('provider_user_id != ?', current_user.id)
    @praises = Praise.where('email != ?', current_user.email)

    @criticism = Criticism.where('provider_user_id != ?', current_user.id)
    @criticisms = Criticism.where('email != ?', current_user.email)

    @general = General.where('provider_user_id != ?', current_user.id)
    @generals = General.where('email != ?', current_user.email)
    
    #high priority 
    @second_priority1 = @praises.where('tip_accept = ? or tip_reject = ? and tip_viewed >= ?', 1, 1, 1 ).order("RANDOM()").first rescue nil
    @second_priority2 = @criticisms.where('tip_accept = ? or tip_reject = ? and tip_viewed >= ? ', 1, 1, 1 ).order("RANDOM()").first rescue nil
    @second_priority3 = @generals.where('tip_accept = ? or tip_reject = ? and tip_viewed >= ?', 1, 1, 1 ).order("RANDOM()").first rescue nil
    
    if @second_priority1.nil?
    #low priority
    @zero_priority1 = @praises.where('tip_accept = ? or tip_reject = ? and tip_viewed = ?', 0, 0, 0).order("RANDOM()").first rescue nil
    @zero_priority2 = @criticisms.where('tip_accept = ? or tip_reject = ? and tip_viewed = ?', 0, 0, 0).order("RANDOM()").first rescue nil
    @zero_priority3 = @generals.where('tip_accept = ? or tip_reject = ? and tip_viewed = ?', 0, 0, 0).order("RANDOM()").first rescue nil
    
    #low priority
    @bb1 = @praises.where('tip_accept >= ? or tip_reject >= ? and tip_viewed >= ?', 0, 0, 0).order("RANDOM()").first rescue nil
    @bb2 = @criticisms.where('tip_accept >= ? or tip_reject >= ? and tip_viewed >= ?', 0, 0, 0).order("RANDOM()").first rescue nil
    @bb3 = @generals.where('tip_accept >= ? or tip_reject >= ? and tip_viewed >= ?', 0, 0, 0).order("RANDOM()").first rescue nil
    @bb4 = [@bb1, @bb2, @bb3].shuffle #logic for random
    a = []
    @bb4.each do |b|
      unless b.nil? && a.count <= 2
        a << b
      end
    end
    @random = a

    h = [@second_priority1,@second_priority2,@second_priority3, @random.last, @random.first]
    @second_priority = h
    
    v = [@zero_priority1,@zero_priority2,@zero_priority3, @random.last, @random.first]
    @zero_priority = v

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
    
  end

  def indiv5
    @ratings = Rating.new    
  end

  def indiv6
    @tips = Tip.all
  end

  def indiv7
    
  end

  def indiv8
    
  end


end



