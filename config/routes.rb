Rails.application.routes.draw do

  root to: 'areas#index'

  get '/areas', to: 'areas#index', as: 'areas'

  get '/schedules', to: 'schedules#show', as: 'show'
  get '/schedules/pick_date', to: 'schedules#pick_date', as: 'pick_date'

  get '/updates/recheck', to: 'updates#recheck', as: 'recheck'
  get '/updates/latest', to: 'updates#latest', as: 'latest_updates'

  get '/map', to: 'maps#capetown_map', as: 'map'

  get '*unmatched_route', to: 'application#not_found'

end
