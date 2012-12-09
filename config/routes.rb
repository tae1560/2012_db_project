DbProject::Application.routes.draw do
  get "sessions/login"
  post "sessions/login_attempt"

  get "sessions/home"
  get "sessions/logout"
  match "sessions", :to => "sessions#home"

  root :to => "sessions#login"

  match "administrators/home"
  match "administrators/profile"
  match "administrators/evaluation_request"
  match "administrators/pro_field"
  match "administrators/sub_field"

  match "evaluators/home"
  match "evaluators/profile"
  match "evaluators/evaluation_request"
  match "evaluators/evaluation_result"
  match "evaluators/sub_field"

  match "sw_developers/home"
  match "sw_developers/profile"
  match "sw_developers/development_results"

  match "requestors/home"
  match "requestors/profile"

  #root :to => "sessions#login"
  #match "signup", :to => "users#new"
  #match "login", :to => "sessions#login"
  #match "logout", :to => "sessions#logout"
  #match "home", :to => "sessions#home"
  #match "profile", :to => "sessions#profile"
  #match "setting", :to => "sessions#setting"

  resources :users
  resources :development_results
  resources :pro_fields
  resources :sub_fields
  resources :evaluation_results
  match "initialize_all_data", :to => "users#initialize_all_data"

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
