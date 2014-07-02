module TipsHelper

def advice
  @tips = Tip.all
  a = []
  @tips.each do |i|
    a << i
  end
  b = a.reverse
  c = b.shift(3)
  tips = []
  b.each do|r|
     tips << Tip.find(r)
     # tips << Tip.where( :user_id => current_user.id, :email => r.email )
  end 
 end
 
  def response
    @response_tip = ResponseTip.all     
  end

end
