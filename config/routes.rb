Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
	namespace :api do
		match '/auth/register' => 'auth#register', :via => :post, :as => :register 
		match '/auth/login' => 'auth#login', :via => :post, :as => :login 
		resources :code_breaker, :only => [:index,:show,:create] do
			post 'guess'
		end
	end
end
