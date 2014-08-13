class IndividualsController < ApplicationController
	respond_to :html, :js
  
  include IndividualsHelper
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
    if @status_check.give_feedback == true
     if @status_check.give_feedback == false
      redirect_to   indiv2_individuals_path
     elsif @status_check.give_rating == false
      redirect_to   indiv4_individuals_path(:email => @status_check.track_last_email)
     elsif @status_check.self_image == false
      redirect_to   indiv5_individuals_path
     elsif @status_check.vote_on_tips == false
      redirect_to   indiv3_individuals_path
     elsif @status_check.invite_others == false 
      redirect_to   indiv6_individuals_path
     else
       @access_reputation_tip = AccessReputationTip.where('user_id = ?', current_user.id)[0] rescue nil
       if @access_reputation_tip.got_feedback <= 5
        redirect_to indiv7_individuals_path
       elsif @access_reputation_tip.got_feedback >= 6
        redirect_to indiv8_individuals_path
       else
        redirect_to  my_mirror_paste_users_path
       end
     end

    else
     
    end
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
      @status_check.update_attributes(:give_feedback => true, :track_last_email => params[:email])
      if params[:praise]
        @praise = Praise.create(:email => params[:email], :praise_comment => params[:praise], :provider_user_id => params[:user_id],:typee => "praise")
      end

      if params[:criticism]
        @criticism = Criticism.create(:email => params[:email], :criticism_comment => params[:criticism],:provider_user_id => params[:user_id], :typee => "criticism")
      end

      if params[:helpful_tips]
        @general = General.create(:email => params[:email], :general_comment => params[:helpful_tips],:provider_user_id => params[:user_id], :typee => "general")
      end

      redirect_to indiv4_individuals_path(:email => params[:email]), notice: "Tips has been provided to this particular user." 
    else
      redirect_to :back
      flash[:notice] = 'Please give at least two out of three tips to complete this step. The quality of your tips matter too.'
    end
  end


  def submit_indiv3
    rating_individuals
      @status_check.update_attributes(:vote_on_tips => true)
      #for onbording sequence quality check
      @quality_check = AccessReputationTip.where('user_id = ?', current_user.id)
      if @quality_check
        a = 5
        @quality_check.first.vote_on_tips = @quality_check.first.vote_on_tips + a
        @aa = @quality_check.first.update_attributes(params[:access_reputation_tip])
      end
    redirect_to indiv6_individuals_path       
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
    @status_check.update_attributes(:give_rating => true, :track_last_email => nil)
    @ratingother = Ratingother.create(
      :email => params[:email],:user_id => current_user.id,
      :trustworthy => params[:trustworthy],:kind_helpful => params[:kind_helpful], 
      :potential => params[:potential], :perform_well => params[:perform_well], 
      :presentable => params[:presentable], :emotianally_mature => params[:emotianally_mature], 
      :friendly_social => params[:friendly_social] , :overall_impresions => params[:overall_impresions]
      )
    redirect_to indiv5_individuals_path, notice: "Thank you for rating this person!" 
  end


  def submit_indiv5
    #for onbording sequence selfimage
     @selfimage = AccessReputationTip.where('user_id = ?', current_user.id)
     a = 1
     if @selfimage
       @selfimage.first.give_selfimage = @selfimage.first.give_selfimage + a
       @selfimage.first.update_attributes(params[:access_reputation_tip])
     end 
    @status_check.update_attributes(:self_image => true)
      @rating = Rating.create(:user_id => current_user.id,:trustworthy => params[:trustworthy],:kind_helpful => params[:kind_helpful], :potential => params[:potential], :perform_well => params[:perform_well], :presentable => params[:presentable], :emotianally_mature => params[:emotianally_mature], :friendly_social => params[:friendly_social], :overall_impresions => params[:overall_impresions])
    redirect_to indiv3_individuals_path, notice: "Your self-ratings were successful." 
  end


  def submit_indiv9
    @paste_user = params[:email]
    @paste_users = params[:email].split(",")
    # raise @paste_users.inspect

    @inviteuser = AccessReputationTip.where('user_id = ?',current_user.id) rescue nil
     
     @paste_users.each do |email|
     p = PasteUser.new(:user_id => current_user.id)
     p.save
     @user_invitation = UserInvitation.new(:user_id => current_user.id, :email => email, :paste_user_id => p.id)
     
     @contact = Contact.create(:user_id => current_user.id, :email => email)
      

      if @user_invitation.save       

        FeedbackMailer.relationship_feedback_invite(@paste_user).deliver     
        
         redirect_to indiv9_individuals_path,:notice => 'Invitation was successfully sent.'  and return 
        # redirect_to new_paste_user_path, :notice => 'Invitation was successfully sent.' 
       else
        redirect_to indiv9_individuals_path and return
      end
    end
  end


  def indiv3
    if @status_check.vote_on_tips == true
     if @status_check.give_feedback == false
      redirect_to   indiv2_individuals_path
     elsif @status_check.give_rating == false
      redirect_to   indiv4_individuals_path(:email => @status_check.track_last_email)
     elsif @status_check.self_image == false
      redirect_to   indiv5_individuals_path
     elsif @status_check.vote_on_tips == false
      redirect_to   indiv3_individuals_path
     elsif @status_check.invite_others == false 
      redirect_to   indiv6_individuals_path
     else
       @access_reputation_tip = AccessReputationTip.where('user_id = ?', current_user.id)[0] rescue nil
       if @access_reputation_tip.got_feedback <= 5
        redirect_to indiv7_individuals_path
       elsif @access_reputation_tip.got_feedback >= 6
        redirect_to indiv8_individuals_path
       else
        redirect_to  my_mirror_paste_users_path
       end
    end

    else
      @praise = Praise.where('provider_user_id != ?', current_user.id)
      @praises = @praise.where('email != ?', current_user.email)

      @criticism = Criticism.where('provider_user_id != ?', current_user.id)
      @criticisms = @criticism.where('email != ?', current_user.email)

      @general = General.where('provider_user_id != ?', current_user.id)
      @generals = @general.where('email != ?', current_user.email)
      
      #high priority 
      @second_priority1 = @praises.where('tip_accept >= ? or tip_reject >= ? and tip_viewed <= ?', 0, 0, 2 ).order("RANDOM()").limit(10) rescue nil
      @second_priority2 = @criticisms.where('tip_accept >= ? or tip_reject >= ? and tip_viewed <= ? ', 0, 0, 2 ).order("RANDOM()").limit(10) rescue nil
      @second_priority3 = @generals.where('tip_accept >= ? or tip_reject >= ? and tip_viewed <= ?', 0, 0, 2 ).order("RANDOM()").limit(10) rescue nil
      b = []
      @second_priority1.each do |praise|
        unless praise.nil? 
          b << praise
        end
      end

      @second_priority2.each do |criticism|
        unless criticism.nil? 
          b << criticism
        end
      end

      @second_priority3.each do |general|
        unless general.nil? 
          b << general
        end
      end
      a = []
      b.each do |random|
        unless a.count >= 5 
          a << random
        end
      end
      @vote_on_tips = a.shuffle
    end
  end




  def indiv4
    if @status_check.give_rating == true
     if @status_check.give_feedback == false
      redirect_to   indiv2_individuals_path
     elsif @status_check.give_rating == false
      redirect_to   indiv4_individuals_path(:email => @status_check.track_last_email)
     elsif @status_check.self_image == false
      redirect_to   indiv5_individuals_path
     elsif @status_check.vote_on_tips == false
      redirect_to   indiv3_individuals_path
     elsif @status_check.invite_others == false 
      redirect_to   indiv6_individuals_path
     else
       @access_reputation_tip = AccessReputationTip.where('user_id = ?', current_user.id)[0] rescue nil
       if @access_reputation_tip.got_feedback <= 5
        redirect_to indiv7_individuals_path
       elsif @access_reputation_tip.got_feedback >= 6
        redirect_to indiv8_individuals_path
       else
        redirect_to  my_mirror_paste_users_path
       end
     end
    else     
    end
  end


  def indiv5      
    if @status_check.self_image == true
     if @status_check.give_feedback == false
      redirect_to   indiv2_individuals_path
     elsif @status_check.give_rating == false
      redirect_to   indiv4_individuals_path(:email => @status_check.track_last_email)
     elsif @status_check.self_image == false
      redirect_to   indiv5_individuals_path
     elsif @status_check.vote_on_tips == false
      redirect_to  indiv3_individuals_path
     elsif @status_check.invite_others == false 
      redirect_to   indiv6_individuals_path
     else
       @access_reputation_tip = AccessReputationTip.where('user_id = ?', current_user.id)[0] rescue nil
       if @access_reputation_tip.got_feedback <= 5
        redirect_to indiv7_individuals_path
       elsif @access_reputation_tip.got_feedback >= 6
        redirect_to indiv8_individuals_path
       else
        redirect_to  my_mirror_paste_users_path
       end
     end
    else
      @ratings = Rating.new
    end  
  end



  def indiv6
    if @status_check.invite_others == true
     if @status_check.give_feedback == false
      redirect_to   indiv2_individuals_path
     elsif @status_check.give_rating == false
      redirect_to   indiv4_individuals_path(:email => @status_check.track_last_email)
     elsif @status_check.self_image == false
      redirect_to   indiv5_individuals_path
     elsif @status_check.vote_on_tips == false
      redirect_to   indiv3_individuals_path
     elsif @status_check.invite_others == false 
      redirect_to indiv6_individuals_path
     else
       @access_reputation_tip = AccessReputationTip.where('user_id = ?', current_user.id)[0] rescue nil
       if @access_reputation_tip.got_feedback <= 5
        redirect_to indiv7_individuals_path
       elsif @access_reputation_tip.got_feedback >= 6
        redirect_to indiv8_individuals_path
       else
        redirect_to  my_mirror_paste_users_path
       end
     end
    else     
    end
  end


  def indiv7
    
  end

  def indiv8
    
  end

  def indiv9
    @paste_user = PasteUser.new

    1.times do
       @paste_user.user_invitations.build
     end
  end
end



