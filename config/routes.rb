MovieApp::Application.routes.draw do
  
  devise_for :users, :controllers => {
    :registrations => "registrations",
    :omniauth_callbacks => "users/omniauth_callbacks"
  } do
    get "logout" => "devise/sessions#destroy"
  end
  
  resources :users do
    member do
      get :records
      get :following
      get :follower
    end
  end
  resources :movies
  resources :people
  resources :news
  resources :records
  root :to => 'movies#index'
  
  # routes for api
  namespace :api do

    get 'promotion' => 'api#promotion'
    namespace :v1 do
      resources :users,:only => [:create, :update] do
        collection do
          get 'friends_list'
          get 'user_info'
        end
      end
      resources :records,:only => [:create, :update, :destroy, :index, :show] do
        collection do
          get 'friend_stream'
          get 'get_movie_records'
        end
        member do
          post 'love'
          delete 'unlove'
        end
      end
      resources :theaters, :only => [:show, :index]
      resources :areas, :only => [:index]
      resources :movies do
        collection do
          get 'hot'
          get 'first_round'
          get 'second_round'
          get 'all'
          get 'comming'
          get 'this_week'
          get 'first_second_comming_hot'
          get 'first_second_comming_hot_update'
          get 'movies_info'
        end 
        member do
          get 'timetable'
        end
      end
      resources :channels, :only => [:index] do
        member do
          get 'channel_time'
        end
      end
      resources :comments,:only => [:create, :destroy]
      resources :streams,:only => [:index]
      resources :news, :only => [:index]
    end
  end

end
