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
    # @advice_contact = AdviceContact.new
    @advice_contact = AdviceContact.new(params[:praise])
    # @advice_contacts = AdviceContact.create(:user_id => current_user.id, :praise => @advice_contact.praise, :criticism => @advice_contact.criticism, :helpful_tips => @advice_contact.helpful_tips)
     if @advice_contact.save
          unless @advice_contact.praise.present? 
            @praise = Praise.create(:provider_user_id => current_user.id,:email => @advice_contact.email, :praise_comment => @advice_contact.praise, :typee => "praise")
          end
          
          unless @advice_contact.criticism.present?
            @criticism = Criticism.create(:provider_user_id => current_user.id,:email => @advice_contact.email, :criticism_comment => @advice_contact.criticism, :typee => "criticism")
          end
          unless @advice_contact.helpful_tips.present?
            @general = General.create(:provider_user_id => current_user.id,:email => @advice_contact.email, :general_comment => @advice_contact.helpful_tips, :typee => "general")
          end
        end
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
    # @ratingother = Ratingother.new(params[:ratingother])
  end

  def indiv5
   # @ratings = Rating.new    
  end

  def indiv6
    
  end

  def indiv7
    
  end


end



