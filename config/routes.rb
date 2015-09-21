Rails.application.routes.draw do
  root 'games#index'

  resources :games, :only => [:index, :show, :destroy] do
    resource :fen, :only => [:show]
    resource :note, :only => [:update]
  end

  resource :pgn, :only => [:new, :create]

end
