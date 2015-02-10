Rails.application.routes.draw do
  get 'auth/:provider/callback' => 'sessions#create'
  get 'auth/failure' => redirect('/')
  get 'signout', to: 'sessions#destroy', as: 'signout'

  resources :sessions, only: [:create, :destroy]
  scope :api do
    resources :teams
    resources :projects do
      resources :boards
    end
    resources :users
    resources :memberships
  end

  #Catch all route for angularjs
  get "*path" => "home#index"
  root 'home#index'
end
