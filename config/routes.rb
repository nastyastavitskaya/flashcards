Rails.application.routes.draw do


  root 'flashcards#index'

  resources :cards
  resources :reviews
  resources :users, only: [:create], controller: 'registrations'
    get '/sign_up', to: 'registrations#new', as: :sign_up

  resources :users, only: [:update], controller: 'profile'
    get '/edit_user', to: 'profile#edit', as: :edit_profile

  resources :sessions, only: [:new, :create, :destroy]
    get '/log_in', to: 'sessions#new', as: :log_in
    delete '/log_out', to: 'sessions#destroy', as: :log_out

      post "oauth/callback" => "oauths#callback"
      get "oauth/callback" => "oauths#callback"
      get "oauth/:provider" => "oauths#oauth", :as => :auth_at_provider


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
