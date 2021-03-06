MovieApp::Application.routes.draw do
  
  devise_for :users
  
  get 'landingpage' => 'landingpage#redirect'

  namespace :api do
    get 'promotion' => 'api#promotion'
    get 'movieinfo_promotion' => 'api#movieinfo_promotion'
    
    namespace :v2 do
      resources :movies, :only => [:index, :show] do
        member do
          get 'timetable'
        end
      end
      resources :records, :only => [:show]  
    end
    namespace :v1 do
      resources :campaigns, :only => [:index, :show] do
        collection do
          get 'announce_list'
        end
        member do
          get 'announce'
        end
      end  
      resources :users,:only => [:create, :update, :destroy] do
        collection do
          get 'friends_list'
          get 'user_info'
          #put : update
          #post : create

        end
      end
      resources :records,:only => [:create, :update, :destroy, :index, :show] do
        collection do
          get 'friend_stream'
          get 'get_movie_records'
          get 'get_movie_records_limit'
          get 'records_with_page'
        end
        member do
          post 'love'
          delete 'unlove'
        end
      end
      resources :theaters, :only => [:show, :index] do
        member do
          get 'get_movies_id'
          get 'get_movies_id_and_hall_str'
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
          get 'movie_info'
          get 'timetablev2'
        end
      end
      resources :channels, :only => [:index] do
        member do
          get 'channel_time'
        end
      end
      resources :comments,:only => [:create, :destroy]
      resources :streams,:only => [:index] do
        collection do
          get 'streams_with_page'
        end
      end
      resources :news, :only => [:index]

      resources :appprojects, :only => [:index]
    end
  end

end
