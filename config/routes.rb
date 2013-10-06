Maily::Engine.routes.draw do
  get ':mailer/:method' => 'emails#show', as: :maily_email
  get 'edit/:mailer/:method' => 'emails#edit', as: :edit_maily_email
  put ':mailer/:method' => 'emails#update', as: :maily_email

  root :to => 'emails#index'
end
