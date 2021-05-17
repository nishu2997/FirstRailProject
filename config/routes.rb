Rails.application.routes.draw do
  get 'login', to: "login#index"
  post 'login', to: "login#validate"
  get 'logout', to: "logout#index"
  root "home#index"
  resources :students
  resources :departments
  resources :courses
  resources :enrolls
end
