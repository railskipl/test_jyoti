Rails.application.routes.draw do


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
    }
  end

  resources :tips

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
      get :import_csv
      post :complete
      get :select_contact_invitation
      post :select_contact_invitation
      get :invitation
      get :my_mirror
    }
  end

  resources :feedbacks
  resources :invitations
  resources :organizations
  resources :individuals
  resources :ratings
  resources :ratingothers

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

  get "import_social_contacts" => "paste_users#import_social_contacts"

  get "/users/:provider/contact_callback" => "home#dashboard"
  get "/contacts/failure" => "home#failure"

  resources :pages
  resources :plans 
  resources :subscriptions
  get 'paypal/checkout', to: 'subscriptions#paypal_checkout'

  post"/success", :to=> "subscriptions#success", :as => 'success'

 
   
   resources :dashboard

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  
  get "home/dashboard"
  root :to => 'home#dashboard'
  

   get '/home/organization' => 'home#organization'
   get '/home/individual' => 'home#individual'
   get '/home/plan' => 'home#plan'
   get '/home/setting' => 'home#setting'
    get '/home/history' => 'home#history'
    get '/home/mspoint' => 'home#mspoint'
    get '/home/help' => 'home#help'
     get '/home/faq' => 'home#faq'
    get '/home/privacypolicy' => 'home#privacypolicy'
    get '/home/term_condition' => 'home#term_condition'
    
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
