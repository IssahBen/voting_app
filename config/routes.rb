Rails.application.routes.draw do
  devise_for :users
  root "pages#home"

  get "poll" , to: "candidates#index"

  put "vote" , to:  "candidates#upvote"
end
