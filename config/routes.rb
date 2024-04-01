Rails.application.routes.draw do
  devise_for :employees

  namespace :api do
    # Define routes for serving homepage data
    root to: "home#index"
    resources :companies, only: [:index, :show]
    resources :employees, only: [:show, :edit, :update]
    resources :timesheet_entries, except: [:show]
  end
end
