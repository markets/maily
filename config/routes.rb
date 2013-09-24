Maily::Engine.routes.draw do

  resources :emails, only: [:index, :show]
  root :to => 'emails#index'

end
