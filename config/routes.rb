Rails.application.routes.draw do
  get 'auth/:provider/callback' => 'sessions#create'
  get 'auth/failure' => redirect('/')
  get 'signout', to: 'sessions#destroy', as: 'signout'

  resources :sessions, only: [:create, :destroy]
  scope :api do
    resources :teams
    resources :projects do
      resources :boards, only: [:index, :new, :create], defaults: { format: 'json' }
    end

    resources :boards, only: [:show, :edit, :update, :destroy] do
      resources :board_items, only: [:index, :new, :create], defaults: { format: 'json' }
    end

    resources :board_items, only: [:index, :show, :edit, :update, :destroy], defaults: { format: 'json' } do
      resources :comments, only: [:index, :new, :create], defaults: { format: 'json' }
    end

    resources :comments, only: [:index, :show, :edit, :update, :destroy], defaults: { format: 'json' }

    resources :users, defaults: { format: 'json' }
    resources :memberships, defaults: { format: 'json' }
    resources :managerships, defaults: { format: 'json'}
  end

  #Catch all route for angularjs
  get "*path" => "home#index"
  root 'home#index'
end
