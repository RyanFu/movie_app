MovieApp::Application.routes.draw do
  
  devise_for :users

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
          get 'get_movie_records_limit'
        end
        member do
          post 'love'
          delete 'unlove'
        end
      end
      resources :theaters, :only => [:show, :index] do
        member do
          get 'get_movies_id'
        end
      end
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
          get 'update_release_date_running_time_youtube'
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
