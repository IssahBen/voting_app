Rails.application.routes.draw do
  devise_for :users
  root "pages#home"

  get "poll" ,to: "candidates#inex"
end
