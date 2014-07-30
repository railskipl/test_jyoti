module IndividualsHelper
 def rating_individuals
 
  if params[:typee_1] == "praise"
     @praise = Praise.where('id = ?', params[:id_1])[0]

    sum = 1
    if params[:response_1] == "true"
      @sum = @praise.tip_accept + sum
      @praise.tip_accept = @sum
    else
      @sum = @praise.tip_reject + sum
      @praise.tip_reject = @sum
    end

    if @praise.tip_accept >= 2
      @w = 1           #for deciding helpful tip
    elsif @praise.tip_reject >= 2 
      @w = 2          #for deciding unhelpful tip
    else 
      @w = 0
    end
    @praise.tip_prediction = @w
    @praise.update_attributes(params[:praise])
  elsif params[:typee_1] == "criticism"

  	@criticism = Criticism.where('id = ?', params[:id_1])[0]

    sum = 1
    if params[:response_1] == "true"
      @sum = @criticism.tip_accept + sum
      @criticism.tip_accept = @sum
    else
      @sum = @criticism.tip_reject + sum
      @criticism.tip_reject = @sum
    end

    if @criticism.tip_accept >= 2
      @w = 1           #for deciding helpful tip
    elsif @criticism.tip_reject >= 2 
      @w = 2          #for deciding unhelpful tip
    else 
      @w = 0
    end
    @criticism.tip_prediction = @w
    @criticism.update_attributes(params[:criticism])

  elsif params[:typee_1] == "general"
    @general = General.where('id = ?', params[:id_1])[0]

    sum = 1
    if params[:response_1] == "true"
      @sum = @general.tip_accept + sum
      @general.tip_accept = @sum
    else
      @sum = @general.tip_reject + sum
      @general.tip_reject = @sum
    end

    if @general.tip_accept >= 2
      @w = 1           #for deciding helpful tip
    elsif @general.tip_reject >= 2 
      @w = 2          #for deciding unhelpful tip
    else 
      @w = 0
    end
    @general.tip_prediction = @w
    @general.update_attributes(params[:general])
  else
  end
 ##################################################################################
  

  if params[:typee_2] == "praise"
       
     @praise = Praise.where('id = ?', params[:id_2])[0]
     sum = 1
     if params[:response_2] == "true"
      @sum = @praise.tip_accept + sum
      @praise.tip_accept = @sum
    else
      @sum = @praise.tip_reject + sum
      @praise.tip_reject = @sum
    end

    if @praise.tip_accept >= 2
      @w = 1           #for deciding helpful tip
    elsif @praise.tip_reject >= 2 
      @w = 2          #for deciding unhelpful tip
    else 
      @w = 0
    end
    @praise.tip_prediction = @w
    @praise.update_attributes(params[:praise])
  elsif params[:typee_2] == "criticism"

  	@criticism = Criticism.where('id = ?', params[:id_2])[0]

     sum = 1
     if params[:response_2] == "true"
      @sum = @criticism.tip_accept + sum
      @criticism.tip_accept = @sum
    else
      @sum = @criticism.tip_reject + sum
      @criticism.tip_reject = @sum
    end

    if @criticism.tip_accept >= 2
      @w = 1           #for deciding helpful tip
    elsif @criticism.tip_reject >= 2 
      @w = 2          #for deciding unhelpful tip
    else 
      @w = 0
    end
    @criticism.tip_prediction = @w
    @criticism.update_attributes(params[:criticism])

  elsif params[:typee_2] == "general"
  	 @general = General.where('id = ?', params[:id_2])[0]

     sum = 1
     if params[:response_2] == "true"
      @sum = @general.tip_accept + sum
      @general.tip_accept = @sum
    else
      @sum = @general.tip_reject + sum
      @general.tip_reject = @sum
    end

    if @general.tip_accept >= 2
      @w = 1           #for deciding helpful tip
    elsif @general.tip_reject >= 2 
      @w = 2          #for deciding unhelpful tip
    else 
      @w = 0
    end
    @general.tip_prediction = @w
    @general.update_attributes(params[:general])
  else
  end
###########################################################################################


  if params[:typee_3] == "praise"
     
    @praise = Praise.where('id = ?', params[:id_3])[0]
    sum = 1
    if params[:response_3] == "true"
      @sum = @praise.tip_accept + sum
      @praise.tip_accept = @sum
    else
      @sum = @praise.tip_reject + sum
      @praise.tip_reject = @sum
    end

    if @praise.tip_accept >= 2
      @w = 1           #for deciding helpful tip
    elsif @praise.tip_reject >= 2 
      @w = 2          #for deciding unhelpful tip
    else 
      @w = 0
    end
    @praise.tip_prediction = @w
    @praise.update_attributes(params[:praise])
  elsif params[:typee_3] == "criticism"

  	@criticism = Criticism.where('id = ?', params[:id_3])[0]

     sum = 1
     if params[:response_3] == "true"
      @sum = @criticism.tip_accept + sum
      @criticism.tip_accept = @sum
    else
      @sum = @criticism.tip_reject + sum
      @criticism.tip_reject = @sum
    end

    if @criticism.tip_accept >= 2
      @w = 1           #for deciding helpful tip
    elsif @criticism.tip_reject >= 2 
      @w = 2          #for deciding unhelpful tip
    else 
      @w = 0
    end
    @criticism.tip_prediction = @w
    @criticism.update_attributes(params[:criticism])

  elsif params[:typee_3] == "general"
  	 @general = General.where('id = ?', params[:id_3])[0]

     sum = 1
     if params[:response_3] == "true"
      @sum = @general.tip_accept + sum
      @general.tip_accept = @sum
    else
      @sum = @general.tip_reject + sum
      @general.tip_reject = @sum
    end

    if @general.tip_accept >= 2
      @w = 1           #for deciding helpful tip
    elsif @general.tip_reject >= 2 
      @w = 2          #for deciding unhelpful tip
    else 
      @w = 0
    end
    @general.tip_prediction = @w
    @general.update_attributes(params[:general])
  else
  end
########################################################################################


  if params[:typee_4] == "praise"
     @praise = Praise.where('id = ?', params[:id_4])[0]
     sum = 1
    if params[:response_4] == "true"
      @sum = @praise.tip_accept + sum
      @praise.tip_accept = @sum
    else
      @sum = @praise.tip_reject + sum
      @praise.tip_reject = @sum
    end

    if @praise.tip_accept >= 2
      @w = 1           #for deciding helpful tip
    elsif @praise.tip_reject >= 2 
      @w = 2          #for deciding unhelpful tip
    else 
      @w = 0
    end
    @praise.tip_prediction = @w
    @praise.update_attributes(params[:praise])
  elsif params[:typee_4] == "criticism"

  	 @criticism = Criticism.where('id = ?', params[:id_4])[0]

     sum = 1
     if params[:response_4] == "true"
      @sum = @criticism.tip_accept + sum
      @criticism.tip_accept = @sum
    else
      @sum = @criticism.tip_reject + sum
      @criticism.tip_reject = @sum
    end

    if @criticism.tip_accept >= 2
      @w = 1           #for deciding helpful tip
    elsif @criticism.tip_reject >= 2 
      @w = 2          #for deciding unhelpful tip
    else 
      @w = 0
    end
    @criticism.tip_prediction = @w
    @criticism.update_attributes(params[:criticism])

  elsif params[:typee_4] == "general"
  	 @general = General.where('id = ?', params[:id_4])[0]

     sum = 1
     if params[:response_4] == "true"
      @sum = @general.tip_accept + sum
      @general.tip_accept = @sum
    else
      @sum = @general.tip_reject + sum
      @general.tip_reject = @sum
    end

    if @general.tip_accept >= 2
      @w = 1           #for deciding helpful tip
    elsif @general.tip_reject >= 2 
      @w = 2          #for deciding unhelpful tip
    else 
      @w = 0
    end
    @general.tip_prediction = @w
    @general.update_attributes(params[:general])
  else
  end
##########################################################################################


  if params[:typee_5] == "praise"
     @praise = Praise.where('id = ?', params[:id_5])[0]
     sum = 1
    if params[:response_5] == "true"
      @sum = @praise.tip_accept + sum
      @praise.tip_accept = @sum
    else
      @sum = @praise.tip_reject + sum
      @praise.tip_reject = @sum
    end

    if @praise.tip_accept >= 2
      @w = 1           #for deciding helpful tip
    elsif @praise.tip_reject >= 2 
      @w = 2          #for deciding unhelpful tip
    else 
      @w = 0
    end
    @praise.tip_prediction = @w
    @praise.update_attributes(params[:praise])
  elsif params[:typee_5] == "criticism"

  	@criticism = Criticism.where('id = ?', params[:id_5])[0]

     sum = 1
     if params[:response_5] == "true"
      @sum = @criticism.tip_accept + sum
      @criticism.tip_accept = @sum
    else
      @sum = @criticism.tip_reject + sum
      @criticism.tip_reject = @sum
    end

    if @criticism.tip_accept >= 2
      @w = 1           #for deciding helpful tip
    elsif @criticism.tip_reject >= 2 
      @w = 2          #for deciding unhelpful tip
    else 
      @w = 0
    end
    @criticism.tip_prediction = @w
    @criticism.update_attributes(params[:criticism])

  elsif params[:typee_5] == "general"
  	 @general = General.where('id = ?', params[:id_5])[0]

     sum = 1
     if params[:response_5] == "true"
      @sum = @general.tip_accept + sum
      @general.tip_accept = @sum
    else
      @sum = @general.tip_reject + sum
      @general.tip_reject = @sum
    end

    if @general.tip_accept >= 2
      @w = 1           #for deciding helpful tip
    elsif @general.tip_reject >= 2 
      @w = 2          #for deciding unhelpful tip
    else 
      @w = 0
    end
    @general.tip_prediction = @w
    @general.update_attributes(params[:general])
  else
  end



 end 	

end
