Rails.application.routes.draw do
  resources :movies do
  	resources :reviews
  end
  post '/movies/search_tmdb'  # Route that posts "Search TMDb form"
  root :to => redirect('/movies')
  get 'auth/:provider/callback' => 'sessions#create'
  get 'logout' => 'sessions#destroy'
  get 'auth/failure' => 'sessions#failure'
end