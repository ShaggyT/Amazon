Rails.application.routes.draw do
  # Admin related routes
  namespace :admin do

    resources :panel, only: [:index]
  end

  # Session related routes
  resource :session, only: [:new, :create, :destroy]

  # User related routes
  resources :users, only: [:new, :create]

  resources :products do
    resources :reviews, only: [:create, :destroy, :edit]
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
