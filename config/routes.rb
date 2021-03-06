Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  root 'dashboard#index'
  get 'users_reports', to: 'dashboard#users_reports'
  devise_for :users, controllers: {invitations: 'devise/invitations', :registrations => "registrations" }
  devise_scope :user do 
  	get "/users" => "users#index"
  	get "/users/new" => "users#new", as: "new_user"
  	get "/users/:id/edit" => "users#edit", as: "edit_user"
  end
  resources :roles
  resources :user_profiles do 
    collection do
      get 'send_invitation_again'
    end
  end
  resources :assign_projects

  resources :projects do
    get 'developers'
    get 'client'
    get 'documents'
    resources :credentials
    resources :documents
    collection do
      post 'assigning_users'
      post 'destroy_assign_user'
    end
    resources :tickets do 
    collection do
      post 'change_status_ticket'
      post 'create_header'
      delete 'remove_header'
      post 'edit_header'
      get 'show_edit_header'
      post 'comment'
      delete 'delete_comment'
      post 'archive'
      get 'list_archive'
    end
  end
  end
  resources :notifications do
    collection do
      post 'update_unread'
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  mount ActionCable.server, at: '/cable'
end
