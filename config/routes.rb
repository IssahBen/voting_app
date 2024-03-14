Rails.application.routes.draw do
  devise_for :users
  root "pages#home"

  

  put "vote" , to:  "candidates#upvote"
  get 'user_root' => 'passingthrough#index'
  get 'voter_home', to: "pages#voter_home"
  get 'admin_home', to: "pages#admin_home"
  resources :ballots do 
    resources :candidates
  end
end
