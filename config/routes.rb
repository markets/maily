Maily::Engine.routes.draw do
  get  ':mailer/:email'            => 'emails#show',       as: :maily_email
  get  ':mailer/:email/raw'        => 'emails#raw',        as: :raw_maily_email
  get  ':mailer/:email/edit'       => 'emails#edit',       as: :edit_maily_email
  put  ':mailer/:email'            => 'emails#update',     as: :update_maily_email
  post ':mailer/:email/deliver'    => 'emails#deliver',    as: :deliver_maily_email
  get  ':mailer/:email/attachment' => 'emails#attachment', as: :attachment_maily_email

  root :to => 'emails#index'
end
