Rails.application.routes.draw do
  root to: 'regions#index'

  get '/regions', to: 'regions#index', as: 'all_regions'
  get '/regions/:id', to: 'regions#show', as: 'show_region'

  get '/areas/:id', to: 'areas#show', as: 'show_area'
  get '/area_schedules/:id', to: 'area_schedules#show', as: 'show_area_schedule'

  get '/region_updates/recheck', to: 'region_updates#recheck', as: 'recheck_region'
  get '/region_updates', to: 'region_updates#latest', as: 'latest_region_updates'
end
