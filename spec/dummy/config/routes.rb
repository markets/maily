Dummy::Application.routes.draw do
  mount Maily::Engine, at: '/maily'

  root to: redirect('/maily')
end
