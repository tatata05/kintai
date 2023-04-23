Rails.application.routes.draw do
  devise_for :admins, controllers: {
    registrations: 'admins/registrations',
    sessions: 'admins/sessions'
  }
  devise_for :employees, controllers: {
    registrations: 'employees/registrations',
    sessions: 'employees/sessions'
  }
  get "admins/home" => "admins#home"
  root "static_pages#home"

  namespace :admin do
    resources :shifts
    resources :absences
    resources :employees
  end
  namespace :employee do
    resources :shifts
    resources :absences
  end
  resources :admins
  resources :employees
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
