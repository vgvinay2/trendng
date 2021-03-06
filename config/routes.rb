require 'sidekiq/web'
Trendng::Application.routes.draw do
	namespace :dashboard do
		match "", to: 'dashboard#index', via: :get 
		match "/users/bulk_invite/:quantity", to: 'users#bulk_invite', via: :get, :as => :bulk_invite
		resources :users do
			get 'invite', :on => :member
		end
    resources :campaigns
    resources :ads
    resources :tweets
    resources :emails
	end
	authenticated :user do
    root to: "dashboard/dashboard#index", as: :authenticated_root
    # mount Sidekiq::Web => '/sidekiq'
  end
  devise_scope :user do
  	root :to => "home#index"
	end
  devise_for :users, :controllers => {:registrations => "registrations", :omniauth_callbacks => "omniauth_callbacks"}
  resources :users, only: [:show, :create]
end