Rails.application.routes.draw do
  devise_for :admins, controllers: {
    registrations: 'admins/registrations',
    sessions: 'admins/sessions'
  }
  devise_for :employees, controllers: {
    registrations: 'employees/registrations',
    sessions: 'employees/sessions'
  }
  get "admin/home" => "admin#home"
  root "static_pages#home"

  namespace :admin do
    resources :absences, only: [:show, :update]
    resources :admins, only: [:index, :show]
    resources :employees, only: [:index, :show, :destroy]
    resources :shifts, only: [:index, :show, :update]
  end
  namespace :employee do
    resources :absences, only: [:new, :create, :show, :destroy]
    resources :employees, only: [:show]
    resources :shifts
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
