Rails.application.routes.draw do
  devise_for :users
  root to: "homes#top"
  get '/home/about'=>'homes#about'
  get 'users/show'
  resources :books, only:[:new, :create, :index, :show, :edit, :update, :destroy ] do
end
  resources :users,only:[:show, :edit, :index ]


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
