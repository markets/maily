Maily::Engine.routes.draw do
  get  ':mailer/:method'            => 'emails#show',       as: :maily_email
  get  ':mailer/:method/raw'        => 'emails#raw',        as: :raw_maily_email
  get  ':mailer/:method/edit'       => 'emails#edit',       as: :edit_maily_email
  put  ':mailer/:method'            => 'emails#update',     as: :update_maily_email
  post ':mailer/:method/deliver'    => 'emails#deliver',    as: :deliver_maily_email
  get  ':mailer/:method/attachment' => 'emails#attachment', as: :attachment_maily_email

  root :to => 'emails#index'
end
