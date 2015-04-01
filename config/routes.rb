Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "callbacks", :registrations => "registrations" }

  devise_scope :user do
    get 'signin' => 'home#index'
  end

  resources :sessions, only: [:create, :destroy]
  scope :api do
    resources :teams
    resources :projects do
      resources :boards, only: [:index, :new, :create], defaults: { format: 'json' }
    end

    resources :boards, only: [:index, :show, :edit, :update, :destroy] do
      resources :board_items, only: [:index, :new, :create], defaults: { format: 'json' }
    end

    get 'boards/:id/events' => 'boards#events'

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
