class FeedbackMailer < ActionMailer::Base
  default from: "from@example.com"

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
end
