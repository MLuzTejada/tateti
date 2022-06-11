Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  get  'boards/:id', to: 'board#show'

  post 'new_game', to: 'game#new_game'
  post 'join_game', to: 'game#join_game'
  post 'other_round/:token', to: 'game#other_round'
  post 'make_move/:token', to: 'game#make_move'

  post 'login', to: 'player#login'
  post 'register', to: 'player#register'
  get 'logout/:id', to: 'player#logout'
  get 'players/:id', to: 'player#show'
 
end
