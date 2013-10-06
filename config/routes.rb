Maily::Engine.routes.draw do
  get ':mailer/:method' => 'emails#show', as: :maily_email
  get 'raw/:mailer/:method' => 'emails#raw', as: :maily_email_raw

  root :to => 'emails#index'
end
