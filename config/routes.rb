Rails.application.routes.draw do


  resources :feedbacks

  resources :invitations

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


  get "/users/:provider/contact_callback" => "home#dashboard"
  get "/contacts/failure" => "home#failure"

   resources :pages
   
   resources :dashboard

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  
  get "home/dashboard"
  root :to => 'home#index'


 


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
