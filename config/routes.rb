Rails.application.routes.draw do
  root 'games#index'

  resources :games do
    resource :fen, :only => [:show]
    resource :note, :only => [:update]
  end
end
