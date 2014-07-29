module RatingsHelper
	def avg_result(column_attribute,value)
	  scores = AvgRating.pluck(column_attribute.to_sym)
	  count = 0
   	  scores.each do |i| 
       if i < value
        count += 1 
       elsif (i == value && scores.count == 1)
        count += 1  	
       end 
  	  end 
	 val =  ((count.to_f/scores.count)*100).round(2)
	 return "#{val}%" 
	end


	def rhd_store_function(column_attribute,value)
		scores = RhdStore.pluck(column_attribute.to_sym)
		count = 0
   	    scores.each do |i| 
          if i < value 
            count += 1 
          elsif (i == value && scores.count == 1)
            count += 1 
          end 
  	    end 
	    val =  ((count.to_f/scores.count)*100).round(2)
	    return "#{val}%" 
	end

	# def avg_result_percent(avg,avg_result1)
	#  avg_result1.overall = avg_result("overall",avg.overall)
	#  avg_result1.trustworthy = avg_result("trustworthy",avg.trustworthy)
	#  avg_result1.kind_helpful = avg_result("kind_helpful",avg.kind_helpful)
	#  avg_result1.potential = avg_result("potential",avg.potential)
	#  avg_result1.presentable = avg_result("presentable",avg.presentable)
	#  avg_result1.perform_well = avg_result("perform_well",avg.perform_well)
	#  avg_result1.emotianally_mature = avg_result("emotianally_mature",avg.emotianally_mature)
	#  avg_result1.friendly_social = avg_result("friendly_social",avg.friendly_social)
	#  avg_result1.user_id = current_user.id
	#  avg_result1.save
	# end
end
