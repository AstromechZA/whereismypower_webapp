Rails.application.routes.draw do
  root to: 'regions#index'

  get '/regions', to: 'regions#index', as: 'all_regions'
  get '/regions/:id', to: 'regions#show', as: 'show_region'

  get '/areas/:id', to: 'areas#show', as: 'show_area'
  get '/area_schedules/:id', to: 'area_schedules#show', as: 'show_area_schedule'
end
