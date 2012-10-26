Subscriptions::Application.routes.draw do
  resources :subscriptions, defaults: { format: 'json' }
end
