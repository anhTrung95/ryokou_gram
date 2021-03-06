Rails.application.routes.draw do
  get 'static_pages/home'
  get 'static_pages/feed'
  get 'static_pages/most_home'
  root 'static_pages#home'
  devise_for :users,
    controllers:{omniauth_callbacks: "users/omniauth_callbacks"}
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".
  resources :users do
    member do
      get :following, :followers
    end
  end

  # You can have the root of your site routed with "root"
  # root 'welcome#index'
  get 'admin' => 'admin#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  resources :places
  resources :place_photos
  resources :reviews do
    member do
      put "like", to: "reviews#like"
      put "unlike", to: "reviews#unlike"
    end
  end
  resources :comments do
    member do
      put "like", to: "comments#like"
      put "unlike", to: "comments#unlike"
    end
  end
  resources :tags, only: [:index, :show]
  resources :relationships, only: [:create, :destroy]
  resources :searches
   
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
