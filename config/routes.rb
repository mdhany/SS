Rails.application.routes.draw do

  #Turns Routes
  get 'fila/:level_id', to: 'turn#index', as: 'turn_level'
  get 'turns/:id', to: 'turn#view', as: 'view_turn'
  get 'turns/new/:level_id', to: 'turn#new', as: 'new_turn'
  post 'turns', to: 'turn#create', as: 'turns'

  resources :payments
  post 'payments/new', to: 'payments#new'
  patch 'payments/:id/sent', to: 'payments#payment_sent', as: 'payment_sent'
  post 'payments/:id/received', to: 'payments#payment_received', as: 'payment_received'
  #post 'payments/upload', to: 'payments#upload'
  get 'payments/:id/confirmation', to: 'payments#confirmation', as: 'payment_confirmation'

  get 'salir', to: 'logins#salir'

  get 'mis_referidos' => 'logins#index', as: 'mis_referidos'
  get 'login_activity/:id' => 'logins#login_activity', as: 'login_activity'
  get 'myturns' => 'logins#my_turns', as: 'my_turns'
  get 'turn_wizard/:level_id' => 'logins#wizard_turn', as: 'turn_wizard'
  post 'turn_wizard/:level_id/validate_referred', to: 'logins#ref_selection'

  #DEvise Routes
  devise_for :logins
  devise_scope :login do
    get   "sign_in" => "devise/sessions#new", :as => :logins_sign_in
    get   "logins/referrals" => "devise/registrations#new", :as => :logins_referrals
  end
  devise_for :managers

  #Pages
  get ':url', to: 'pages#show', as: 'show_page'

  namespace :admin do
    resources :pages, :logins, :payments, :turns, :levels, :capacities
  end

  root 'logins#my_turns'

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
