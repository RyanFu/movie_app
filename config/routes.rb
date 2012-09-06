MovieApp::Application.routes.draw do
  
  devise_for :users

  namespace :api do
    namespace :v1 do
      resources :users,:only => [:create, :update] do
        collection do
          get 'friends_list'
        end
      end
      resources :records,:only => [:create, :update, :destroy, :index, :show] do
        collection do
          get 'friend_stream'
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
        end 
      end
      resources :comments,:only => [:create, :destroy]
      resources :streams,:only => [:index]
    end
  end

end
