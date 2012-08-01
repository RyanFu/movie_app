MovieApp::Application.routes.draw do
  
  devise_for :users

  namespace :api do
    namespace :v1 do
      resources :users,:only => [:create, :update]
      resources :reports,:only => [:create, :update, :destroy]
      resources :theaters, :only => [:show, :index]
    end
  end

end
