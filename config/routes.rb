Rails.application.routes.draw do
  devise_for :employees

  namespace :api do
    # Define routes for serving homepage data
    get '/home', to: 'home#index'
    
    # Other API routes can be defined here
  end

  root to: 'api/home#index'

  authenticated :employee do
    root 'employees#show', as: :authenticated_root
  end

  # Resources for employees, with nested resources for timesheet entries
  resources :employees, only: [:show, :edit, :update] do
    resources :timesheet_entries, except: [:show]
  end

  # Simple routes for companies and messages, assuming basic CRUD operations
  resources :companies, only: [:index, :show]
  resources :messages, only: [:index, :new, :create]
end
