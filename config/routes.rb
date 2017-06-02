Rails.application.routes.draw do
  get 'login/index'
  post 'login/login'
  get 'login/logout'

  root 'login#index'

  resources :users do
    resources :todos
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
