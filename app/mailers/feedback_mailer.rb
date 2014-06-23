class FeedbackMailer < ActionMailer::Base
   default from: "m360.com"

  # def feedback_mailer(feedback)
  #   @feedback = feedback
  #   email4 = "priya11051988@gmail.com"
  #   recipients =  email4
  #   subject = "Feedback"
  #   mail(:subject => 'Feedback', :to => recipients) 
  # end 

  def feedback_mailer(feedback)
    @feedback = feedback
   
    subject = "Feedback"
    mail(:subject => 'Feedback', :to => feedback.email) 
  end 

  def relationship_feedback(relationship)
    @relationship = relationship
   
    subject = "Please send me Feedback"
    mail(:subject => 'Relationship Feedback', :to => relationship.email) 
  end 
end
