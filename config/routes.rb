Rails.application.routes.draw do
  resources :movies
  root :to => redirect('/movies')
end

get 'auth/:provider/callback' => 'sessions#create'
post 'logout' => 'sessions#destroy'
get 'auth/failure' => 'sessions#failure'