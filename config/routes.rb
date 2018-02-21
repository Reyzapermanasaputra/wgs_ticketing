Rails.application.routes.draw do
  root 'tickets#index'
  devise_for :users, controllers: {invitations: 'devise/invitations', :registrations => "registrations" }
  devise_scope :user do 
  	get "/users" => "users#index"
  	get "/users/new" => "users#new", as: "new_user"
  	get "/users/:id/edit" => "users#edit", as: "edit_user"
  end
  resources :roles
  resources :user_profiles
  resources :assign_projects
  resources :projects
  resources :tickets do 
    collection do
      post 'change_status_ticket'
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  mount ActionCable.server, at: '/cable'
end
