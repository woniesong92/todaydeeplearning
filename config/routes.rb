require 'sidekiq/web'

Rails.application.routes.draw do
  root 'arvix_papers#index'

  # Authentication routes
  devise_for :users

  # Sidekiq monitoring dashboard
  authenticate :user, -> (u) { u.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end

  # Custom routes
  get 'home/index'

  resources :arvix_papers, only: [:index, :show, :update] do
    member do
      post :upvote
      post :downvote
    end
  end
end
