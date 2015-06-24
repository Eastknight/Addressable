Rails.application.routes.draw do

  devise_for :users, skip: [:password]
  root 'landings#index'

  get '/contacts/check-email' =>"contacts#check_email" 
  get '/contacts/check-phone' =>"contacts#check_phone" 

  resources :contacts, only: [:index, :create, :update, :destroy]
end
