Rails.application.routes.draw do
  match "/delayed_job", to: DelayedJobWeb, anchor: false, via: [:get, :post]
  # get 'tags/index'
  get '/tags' => 'tags#index'
  # get 'tags/show'
  get '/tags/:id' => 'tags#show', as: :tag

  # Admin related routes
  namespace :admin do

    resources :panel, only: [:index]
  end

  # Session related routes
  resource :session, only: [:new, :create, :destroy]

  # User related routes
  resources :users, only: [:new, :create]

  # resources :products do
  #   resources :reviews, only: [:create, :destroy, :edit, :update] do
  #     resources :loves, only: [:create, :destroy], shallow: true
  #   end
  # end

  resources :products do
    resources :likes, only: [:create, :destroy], shallow: true
    resources :favourites, only: [:create, :destroy], shallow: true
    resources :votes, only: [:create, :update, :destroy], shallow: true
    resources :reviews, only: [:create, :destroy, :edit, :update] do
      resources :loves, only: [:create, :destroy], shallow: true
      member do
        patch :toggle_hidden
        # toggle_hidden_product_review_path
        # POST	/products/:product_id/reviews/:id/toggle_hidden(.:format)
        # reviews#toggle_hidden
      end
    end
    resources :reviews, only: [], shallow: true do
        resources :review_votes, only: [:create, :update, :destroy], shallow: true
    end
  end


  # the line below defines a Rails route. The routes says here: if we receive
  # an HTTP, GET request with url `/` (home page) then handle the request with
  # the WelcomeController using the index action (method in the the controller)
  # `as: :home` will generate a url helper: home_path that maps to the same url

  # get('/products/new', to: 'products#new', as: :new_product)
  # post('/products/', to: 'products#create', as: :products)
  #
  # get('/products/:id', to: 'products#show', as: :product)
  # get('/products', to: 'products#index')
  #
  # delete('products/id', to: 'products#destroy' )
  #
  #
  # get('/products/:id/edit', to: 'products#edit', as: :edit_product)
  # patch('/products/:id', to: 'products#update')


  get('/', { to: 'welcome#index', as: :home })

  get('/about', { to: 'welcome#about' })

  get('/contact', { to: 'contact#create' })

  post('/contact', { to: 'contact#create' })
end
