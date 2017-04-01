Rails.application.routes.draw do
  root 'arvix_papers#index'

  get 'home/index'

  resources :arvix_papers, only: [:index, :show]
end
