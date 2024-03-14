Rails.application.routes.draw do
  devise_for :users
  root "pages#home"
  put "vote" , to:  "candidates#upvote"
  get 'user_root' => 'passingthrough#index'
  get 'voter_home', to: "pages#voter_home"
  get 'admin_home', to: "pages#admin_home"
  resources :ballots do 
    resources :candidates, only: [:create, :new,:edit,:update]
  end

  # resources :candidates,only: [:edit,:update]
  delete "delete_ballot_candidate",to: "ballot_candidate#destroy"
end
