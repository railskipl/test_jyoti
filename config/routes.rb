Rails.application.routes.draw do

  resources :score_factors

  resources :response_tips

  resources :trial_days

  resources :plans

  resources :sponsercfs

  resources :sponsers

  resources :sponsees

  resources :sponsee_approvals

  resources :relationships do
    collection {
      get :cal
      post :add_power_group
      get :power_group
      get :feedback_relationship
      post :add_feedback
      get :power_feedback
      post :power_feedback
      get :feedback_form
    }
  end

   post '/power_group' => "relationships#power_group1"


  resources :tips do
    collection {
      get :helpful_tips
      get :unhelpful_tips
      get :tips
      get :tip
      get :advice
      get :respond_tips
      get :responses_to_your_tips
      get :tips_and_rating
      get :rejected_tips
      post :tips_response
      get :admin_approve_tip
      get :power_tips
      get :check_history
      get :votes
    }
  end

  resources :factors

  resources :influences
  resources :friends



  resources :advice_contacts do
    collection {
      get :post_login
    }
  end

  resources :user_invitations

  resources :circles

  resources :paste_users do
    collection {
      get :invite
      get :select_contacts
      post :select_contacts
      get :import_csv
      post :complete
      get :select_contact_invitation
      post :select_contact_invitation
      get :invitation
      get :my_mirror
      get :mirror_me
    }
  end

  resources :feedbacks do 
     collection {
      get  :thanks_msg
     }
   end


  resources :invitations
  resources :organizations do
    collection{
      get :org2
    }
  end


  resources :individuals do
    collection {
      get :indiv_path
      get :indiv2
      get :indiv3
      get :indiv4
      get :indiv5
      get :indiv6
      get :indiv7
      get :indiv8
      get :indiv9
    }
  end

  resources :ratings do
    collection {
      get :report
    }

  end 
  
  resources :ratingothers do
  collection {
    get :encourage_signing_up
  }
end
  resources :emails do 
     collection {
      get  :verify
      get  :merge
      get  :primary
     }
   end

  resources :tips do
    collection {
      post :merge_email
      post :demerge_email
    }
  end
    
  devise_for :users, :controllers => {:omniauth_callbacks => "omniauth_callbacks",:registrations=>"registrations"}
  post '/signup/:invitation_token', :to =>'users#new', :as =>'signup'
  

  
  resources :users do
    collection { 
      post :import 
      get :merge
      get  :primary
      get :sign_out
      get :edit
    }
  end

   get '/users/:id/toggled_status', :to => 'users#toggled_status'

   get "/pages/:id/status", :to => "pages#status"
   
  #get 'users/sign_out' => "devise/sessions#destroy"
  #get  '/sign_out' :to 'sessions#destroy', :via [:delete]
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".
  resources :omniauth_callbacks

  get "/import_contact" => "home#import_contact"
  get 'users/auth/:provider/callback' => 'omniauth_callbacks#google_oauth2'
  get "import_social_contacts" => "paste_users#import_social_contacts"
  get '/reputation_report/failure' => "ratingothers#failure"
  get '/reputation_report/failure1' => "ratingothers#failure1"
  get '/reputation_report/failure2' => "ratingothers#failure2"
  get "/users/:provider/contact_callback" => "home#dashboard"
  get "/contacts/failure" => "home#failure"
  post '/indiv2' => "individuals#submit_indiv2"
  post '/indiv3' => "individuals#submit_indiv3"
  post '/indiv4' => "individuals#submit_indiv4"
  post '/indiv5' => "individuals#submit_indiv5"
  post '/indiv9' => "individuals#submit_indiv9"
  post '/facebook' => "individuals#facebook"

  resources :pages do
    collection {
      get :faq

      get :contactus
      get :privacypolicy
      get :term_condition

    }
  end

  resources :plans 
  resources :subscriptions
  get 'paypal/checkout', to: 'subscriptions#paypal_checkout'
  # get 'paypal/checkout', to: 'subscriptions#paypal_checkout'
  # get "/success", :to=> "subscriptions#success", :as => 'success'

 
   
   resources :dashboard

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  
  get "home/dashboard"
  root :to => 'home#dashboard'

  # get "paste_users/my_mirror"
  # root :to => 'paste_users#my_mirror'
  

   get '/home/organization' => 'home#organization'
   get '/home/individual' => 'home#individual'
   get '/home/learn_more' => 'home#learn_more'
   get '/home/home' => 'home#home'
   get '/home/plan' => 'home#plan'
   get '/home/setting' => 'home#setting'
    get '/home/history' => 'home#history'
    get '/home/mspoint' => 'home#mspoint'
    get '/home/help' => 'home#help'
    get '/home/tip_rating' => 'home#tip_rating'
    get '/home/how_it_works' => 'home#how_it_works'
    get '/home/how_it_works_for_me' => 'home#how_it_works_for_me'
    get '/home/how_it_works_for_my_team' => 'home#how_it_works_for_my_team'
    get 'home/fork_users' => 'home#fork_users'
    get '/reputation_report' => 'ratings#reputation_report'
    get '/approved_tips' => 'tips#approved_tips'
    get '/sensitive_tips' => 'tips#sensitive_tips'
    get '/react_to_response' => 'tips#react_to_response'
    post '/react_to_response' => 'tips#submit_response'
    get '/respond_to_tip' => 'tips#respond_to_tip'
    post '/respond_to_tip' => 'tips#submit_respond_tip'

    get '/reaction_for_response' => 'tips#reaction_for_response'
    post '/reaction_for_response' => 'tips#submit_reaction'
    resource :contactus
   get '/home/contactus' => 'home#contactus'

   get '/pages/:id' => 'pages#show' 


  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
