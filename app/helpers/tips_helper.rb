module TipsHelper

# def advice
#   @tips = Tip.all
#   a = []
#   @tips.each do |i|
#     a << i
#   end
#   b = a.reverse
#   c = b.shift(3)
#   tips = []
#   b.each do|r|
#      tips << Tip.find(r)
#      # tips << Tip.where( :user_id => current_user.id, :email => r.email )
#   end 
#  end
 
#   def response
#     @response_tip = ResponseTip.all     
#   end

  def condition_check
  @praise = Praise.where('email = ?', current_user.email).order('created_at DESC') rescue nil
  @criticism = Criticism.where('email = ?', current_user.email).order('created_at DESC') rescue nil
  @general = General.where('email = ?', current_user.email).order('created_at DESC') rescue nil

  @praise_owner_tip = Praise.where('provider_user_id = ?',current_user.id).order('created_at DESC') rescue nil
  @criticism_owner_tip = Criticism.where('provider_user_id = ?',current_user.id).order('created_at DESC') rescue nil
  @general_owner_tip = General.where('provider_user_id = ?',current_user.id).order('created_at DESC') rescue nil
 end

 def gottips
    @criticisms = Criticism.where('provider_user_id != ? and email = ? and status = ?',current_user.id, current_user.email, false).select('DISTINCT(provider_user_id)').order('created_at DESC') rescue nil
    @critic = Criticism.where('provider_user_id IS ? and email = ? and status = ?', nil, current_user.email, false).order('created_at DESC') rescue nil    
    all_critic = @criticisms.count + @critic.count
    
    @praises = Praise.where('provider_user_id != ? and email = ? and status = ?',current_user.id, current_user.email, false).select('DISTINCT(provider_user_id)').order('created_at DESC') rescue nil
    @praisecount = Praise.where('provider_user_id IS ? and email = ? and status = ?', nil, current_user.email, false).order('created_at DESC') rescue nil    
    all_praise = @praises.count + @praisecount.count
    #raise @all_praise.inspect
    
    @generals = General.where('provider_user_id != ? and email = ? and status = ?', current_user.id, current_user.email, false).select('DISTINCT(provider_user_id)').order('created_at DESC') rescue nil
    @generalcount = General.where('provider_user_id IS ? and email = ? and status = ?', nil, current_user.email, false).order('created_at DESC') rescue nil    
    all_general = @generals.count + @generalcount.count

    if all_critic >= 5 
       a = all_critic
    elsif all_praise >= 5
       a = all_praise
    elsif all_general >= 5
       a = all_general
    else
      if all_critic <= 5
        a = all_critic
      elsif all_praise <= 5
        a = all_praise
        else
          a = all_general
        end
    end
 end


  def date_check
    @start_date = (Date.today - 30.days).to_s
    @end_date = Date.today.to_s
  end

  def tips_provided
    date_check
    @praise = Praise.where('created_at >= ? and Date(created_at) <= ? and provider_user_id = ?',@start_date,@end_date,current_user.id).order('created_at DESC') rescue nil
    @criticism = Criticism.where('created_at >= ? and Date(created_at) <= ? and provider_user_id = ?',@start_date,@end_date,current_user.id).order('created_at DESC') rescue nil
    @general = General.where('created_at >= ? and Date(created_at) <= ? and provider_user_id = ?',@start_date,@end_date,current_user.id).order('created_at DESC') rescue nil
  end

  def votes_invites_track
    date_check
    @vote_track = VoteTrack.where('created_at >= ? and Date(created_at) <= ? and user_id = ? and name = ?',@start_date,@end_date,current_user.id, "vote_on_tips").order('created_at DESC') rescue nil
    @track_invites = VoteTrack.where('created_at >= ? and Date(created_at) <= ? and user_id = ? and name = ?',@start_date,@end_date,current_user.id, "invitations").order('created_at DESC') rescue nil
  end

  def tips_other
    date_check
    @criticisms = Criticism.where('created_at >= ? and Date(created_at) <= ? and provider_user_id != ? and email = ? and status = ?',@start_date,@end_date,current_user.id, current_user.email, false).select('DISTINCT(provider_user_id)').order('created_at DESC') rescue nil
    @critic = Criticism.where('created_at >= ? and Date(created_at) <= ? and provider_user_id IS ? and email = ? and status = ?', @start_date, @end_date, nil, current_user.email, false).order('created_at DESC') rescue nil    
    @all_critic = @criticisms.count + @critic.count

    @praises = Praise.where('created_at >= ? and Date(created_at) <= ? and provider_user_id != ? and email = ? and status = ?',@start_date,@end_date,current_user.id, current_user.email, false).select('DISTINCT(provider_user_id)').order('created_at DESC') rescue nil
    @praisecount = Praise.where('created_at >= ? and Date(created_at) <= ? and provider_user_id IS ? and email = ? and status = ?', @start_date, @end_date, nil, current_user.email, false).order('created_at DESC') rescue nil    
    @all_praise = @praises.count + @praisecount.count
    #raise @all_praise.inspect

    @generals = General.where('created_at >= ? and Date(created_at) <= ? and provider_user_id != ? and email = ? and status = ?',@start_date,@end_date,current_user.id, current_user.email, false).select('DISTINCT(provider_user_id)').order('created_at DESC') rescue nil
    @generalcount = General.where('created_at >= ? and Date(created_at) <= ? and provider_user_id IS ? and email = ? and status = ?', @start_date, @end_date, nil, current_user.email, false).order('created_at DESC') rescue nil    
    @all_general = @generals.count + @generalcount.count
  end

  # def update_status
  #   @praise_status = Praise.where('email = ? and status = ?', current_user.email, false).order('created_at DESC') rescue nil
  #   @criticism_status = Criticism.where('email = ? and status = ?', current_user.email, false).order('created_at DESC') rescue nil
  #   @general_status = General.where('email = ? and status = ?', current_user.email, false).order('created_at DESC') rescue nil 
  #   @praise_status.each do |praise|
  #     praise.update_attributes(:status => true)
  #   end
  #   @criticism_status.each do |criticism|
  #     criticism.update_attributes(:status => true)
  #   end
  #   @general_status.each do |general|
  #     general.update_attributes(:status => true)
  #   end
  # end
end
