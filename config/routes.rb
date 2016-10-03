Rails.application.routes.draw do
  devise_for :users
  root to: 'dashboard#info'

  get '/dashboard' => 'dashboard#index'
  post '/timesync' => 'dashboard#timesync'
  get '/info' => 'dashboard#info'

  resources :clubs
  resources :race_results do
    collection do
      post :from_timing
    end
  end
  resources :races
  resources :racers do
    collection do
      get :login, to: 'racers#login_form'
      post :login
    end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
