Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post 'auth/login', to: 'authentication#login'

  post '/save_favorite_beer' => 'beers#save_favorite_beer'
  post '/beers_list' => 'beers#beers_list'
  get '/my_favorite_beer' => 'beers#my_favorite_beer'
  get '/all' => 'beers#all_beers'
  resources :beers
end
