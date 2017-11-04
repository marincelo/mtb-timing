Rails.application.routes.draw do
  root to: 'dashboard#info'

  devise_for :users

  get '/timing' => 'dashboard#index'
  get '/live' => 'dashboard#live'
  post '/timesync' => 'dashboard#timesync'
  get '/info' => 'dashboard#info'
  get '/terms' => 'dashboard#terms'

  resources :clubs

  resources :race_results do
    collection do
      post :from_timing
      delete :destroy_from_timing
      match :from_device, via: [:get, :post]
    end
  end

  resources :races do
    collection do
      get :get_live
    end
  end

  resources :racers do
    collection do
      get :login, to: 'racers#login_form'
      post :login
    end
  end

  resources :start_numbers do
    collection do
      get :query
    end
  end
end
