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

  def submit_indiv2
    @praise = Praise.create(:email => params[:email], :praise_comment => params[:praise], :provider_user_id => params[:user_id],:typee => "praise")

    @criticism = Criticism.create(:email => params[:email], :criticism_comment => params[:criticism], :typee => "criticism")

    @general = General.create(:email => params[:email], :general_comment => params[:helpful_tips], :typee => "general")
    
    redirect_to indiv3_individuals_path
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



