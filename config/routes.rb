Rails.application.routes.draw do
  root 'static_pages#home'
  get '/' => 'static_pages#home'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  get '/signup' => 'users#new', as: :signup
  post '/users' => 'users#create'
  get '/users/:id' => 'users#show', as: :user_show
  get '/users/:id/edit' => 'users#edit', as: :user_edit
  put '/users/:id' => 'users#update', as: :user_update
  # delete '/users/:id/leave_abode' => 'users#leave_abode', as: :leave_abode

  get '/abodes/join' => 'users#join', as: :user_join
  put '/abodes' => 'users#add', as: :user_add

  get '/abodes/expenses' => 'expenses#index', as: :expenses_list
  post '/abodes/:id/expenses' => 'expenses#create', as: :expenses
  get '/expenses/:id' => 'expenses#show', as: :expense_show
  get '/expenses/:id/edit' => 'expenses#edit', as: :expense_edit
  put '/expenses/:id' => 'expenses#update', as: :expense_update
  delete '/expenses/:id' => 'expenses#destroy', as: :expense_destroy

  get '/signin' => 'sessions#new', as: :signin
  post '/signin' => 'sessions#create', as: :sessions
  delete '/signout' => 'sessions#destroy', as: :signout

  get '/abodes/new' => 'dwellings#new', as: :dwellings_new
  post '/abodes' => 'dwellings#create', as: :dwellings
  get '/abodes/:id' => 'dwellings#show', as: :dwelling_show
  get '/abodes/:id/edit' => 'dwellings#edit', as: :dwelling_edit
  put '/abodes/:id' => 'dwellings#update', as: :dwelling_update

  resources :abodes do
    resources :comments, only: [:index, :new, :create, :destroy, :update]
  end

  resources :expenses do
    resources :comments, only: [:index, :new, :create, :destroy, :update]
  end

  resources :users do
    resources :emergency_contacts
  end

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
