Maily::Engine.routes.draw do
  get ':mailer/:method' => 'emails#show', as: :maily_email

  root :to => 'emails#index'
end
