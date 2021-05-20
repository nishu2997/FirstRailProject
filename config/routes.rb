Rails.application.routes.draw do
  get 'login', to: "login#index"
  post 'login', to: "login#validate"
  get 'logout', to: "logout#index"
  root "home#index"
  resources :students do
    resources :enrolls, only: [:index, :new, :create, :destroy]
  end
  resources :departments
  resources :courses
end
