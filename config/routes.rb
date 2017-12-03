Rails.application.routes.draw do
  root 'calculations#index'
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :calculations, only: :index
end
