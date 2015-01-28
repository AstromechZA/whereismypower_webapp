Rails.application.routes.draw do
  root to: 'home#index'
  get '*unmatched_route', to: 'home#index'
end
