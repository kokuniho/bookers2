Rails.application.routes.draw do

  devise_for :users
  # , controllers: { registrations: 'users/registrations' }
  root to: "homes#top"
  get '/home/about'=>'homes#about'
  get 'users/show'
  get 'search' => 'searches#search', as: 'search'
  resources :books, only:[:new, :create, :index, :show, :edit, :update, :destroy ] do
    resources:book_comments, only:[:create, :destroy]
    resource :favorites, only:[:create, :destroy]
  end
  resources :users,only:[:show, :edit, :update, :index ] do
    resource :relationships, only:[:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
  end

  devise_scope :user do
    post 'users/guest_sign_in',to: 'users/sessions#guest_sign_in'
  end
end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.hend
