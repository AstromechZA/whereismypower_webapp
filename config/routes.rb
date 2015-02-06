Rails.application.routes.draw do

  root to: 'areas#index'

  get '/areas', to: 'areas#index', as: 'areas'

  get '/schedules', to: 'schedules#show', as: 'show'
  get '/schedules/pick_date', to: 'schedules#pick_date', as: 'pick_date'

  get '/updates/recheck', to: 'updates#recheck', as: 'recheck'
  get '/updates/latest', to: 'updates#latest', as: 'latest_updates'

  get '/map', to: 'maps#capetown_map', as: 'map'

  # API calls

  get '/api', to: 'api#index', as: 'show_apis'
  get '/api/list_areas', to: 'api#list_areas', as: 'api_list_areas', defaults: { format: :json }
  get '/api/get_schedule', to: 'api#get_schedule', as: 'api_get_schedule', defaults: { format: :json }
  get '/api/get_status', to: 'api#get_status', as: 'api_get_status', defaults: { format: :json }

  # legacy routes
   get '/regions/:x', to: redirect('/areas')

  get '*unmatched_route', to: 'application#not_found'

end
