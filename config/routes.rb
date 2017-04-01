Rails.application.routes.draw do
  devise_for :users
  root 'arvix_papers#index'

  get 'home/index'

  resources :arvix_papers, only: [:index, :show]
end
