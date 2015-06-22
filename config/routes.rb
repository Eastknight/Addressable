Rails.application.routes.draw do

  devise_for :users, skip: [:password]
  root 'landings#index'
end
