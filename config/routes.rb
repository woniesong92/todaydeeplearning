Rails.application.routes.draw do
  root 'arvix_papers#index'

  # Authentication routes
  devise_for :users

  # Custom routes
  get 'home/index'

  resources :arvix_papers, only: [:index, :show, :update] do
    member do
      post :upvote
      post :downvote
    end
  end
end
