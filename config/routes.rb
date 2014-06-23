Rails.application.routes.draw do


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
      post :complete
      get :select_contact_invitation
      post :select_contact_invitation
      get :invitation
    }
  end

  resources :feedbacks
  resources :invitations
  resources :organizations
  resources :individuals
  resources :ratings
  resources :ratingothers

  devise_for :users, :controllers => {:omniauth_callbacks => "omniauth_callbacks",:registrations=>"registrations"}
  post '/signup/:invitation_token', :to =>'users#new', :as =>'signup'

  resources :users do
    collection { post :import }
  end

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
   get "/pages/:id/status", :to => "pages#status"
   
   resources :dashboard

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  
  get "home/dashboard"
  root :to => 'home#dashboard'

   get '/home/organization' => 'home#organization'
   get '/home/individual' => 'home#individual'
 


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
