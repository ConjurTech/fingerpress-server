Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :employees, only: [:index, :create, :show, :update, :destroy] do
        member do
          post :check_in
          post :check_out
          post :register
        end
      end
    end
  end
  resources :pay_rolls
  devise_for :admins, :controllers => {sessions: 'admins/sessions', registrations: 'admins/registrations'}

  resources :holidays
  resources :time_logs
  resources :pay_schemes
  resources :employees do
    member do
      post :check_in
      post :check_out
      post :register
    end
  end
  resources :pay_rolls, except: [:edit] do
    member do
      post :mark_all_paid
    end
  end
  resources :payment_records do
    collection do
      get :new_pay_roll
      post :create_pay_roll
    end
  end
  resources :payment_record_pay_schemes
  resources :config, except: [:index, :new, :create, :show]
  get 'config/edit' => 'config#edit'
  post 'config/update' => 'config#update'
  get 'config/show_api_key' => 'config#show_api_key'
  root 'time_logs#index'
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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
