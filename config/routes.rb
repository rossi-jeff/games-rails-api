Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
	namespace :api do
		match '/auth/register' => 'auth#register', :via => :post, :as => :register 
		match '/auth/login' => 'auth#login', :via => :post, :as => :login 
		resources :code_breaker, :only => [:index,:show,:create] do
			post 'guess'
			collection do
				get 'progress'
			end
		end
		resources :yacht, :only => [:index,:show,:create] do
			post 'roll'
			post 'score'
		end
		resources :sea_battle, :only => [:index,:show,:create] do
			post 'ship'
			post 'fire'
		end
		resources :concentration, :only => [:index,:show,:create,:update]
		resources :klondike, :only => [:index,:show,:create,:update]
		resources :free_cell, :only => [:index,:show,:create,:update]
		resources :ten_grand, :only => [:index,:show,:create] do
			post 'roll'
			post 'score'
			collection do
				post 'options'
			end
		end
		get '/word/:id', :to => 'word#show'
		post '/word/random', :to => 'word#random'
		resources :guess_word, :only => [:index,:show,:create] do
			post 'guess'
			collection do
				post 'hint'
				get 'progress'
			end
		end
		resources :hang_man, :only => [:index,:show,:create] do
			post 'guess'
		end
	end
end
