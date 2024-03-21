# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  root 'pages#home'
  get "verification_page" ,to: "pages#verification"
  put 'vote', to: 'candidates#upvote'
  get 'user_root' => 'passingthrough#index'
  get 'voter_home', to: 'pages#voter_home'
  get 'voting_area', to: 'votingarea#show'
  resources :ballots do
    resources :candidates, only: %i[create new edit update]
  end
  resources :voters

  resources :candidates, only: %i[index destroy]
  delete 'delete_ballot_candidate', to: 'ballot_candidate#destroy'

  namespace :api do  
    namespace :v1 do 
      resources :voters, only: [:index]
    end

    namespace :v2 do 
      resources :voters, only: [:index]
    end 
  end

   put "verify", to: "verification#verify"

   resource :upload,only: [:create,:show]
end
