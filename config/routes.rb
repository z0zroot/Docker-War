require 'sidekiq/web'
DockerWar::Application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  authenticate :user, lambda { |u| u.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end
  mount StatusPage::Engine =>'/'
  root 'pages#index'

  match '/home', to: 'pages#home', via: 'get'
  match '/chatroom', to: 'pages#chatroom', via: 'get'

  match '/qna', to: 'pages#qna', via: 'get'
  match '/new_q', to: 'pages#new_q', via: 'post'
  match '/qna_ans', to: 'pages#qna_ans', via: 'patch'
  match '/qna_edit', to: 'pages#qna_edit', via: 'patch'
  match '/qna_delete', to: 'pages#qna_delete', via: 'delete'

  match '/rule', to: 'pages#rule', via: 'get'
  match '/about', to: 'pages#about', via: 'get'
  match '/wargame', to: 'pages#wargame', via: 'get'
  match '/rank', to: 'pages#rank', via: 'get'
  match '/trend', to: 'pages#trend', via: 'get'
  match '/completed_records', to: 'pages#completed_records', via: 'get'
  match '/timeline', to: 'pages#timeline', via: 'get'
  match '/get_agent_details', to: 'pages#get_agent_details', via: 'post'

  match '/wargame/basic', to: 'basic#index', via: 'get'
  match '/wargame/basic/save', to: 'basic#content_save', via: 'patch'
  match '/wargame/basic/edit', to: 'basic#content_edit', via: 'patch'
  match '/wargame/basic/level1', to: 'basic#level1', via: [ 'get', 'post' ]
  match '/wargame/basic/level2', to: 'basic#level2', via: [ 'get', 'post' ]
  match '/wargame/basic/level3', to: 'basic#level3', via: [ 'get', 'post' ]
  match '/wargame/basic/level4', to: 'basic#level4', via: [ 'get', 'post' ]
  match '/wargame/basic/level5', to: 'basic#level5', via: [ 'get', 'post' ]

  match '/wargame/web', to: 'web#index', via: 'get'
  match '/wargame/web/save', to: 'web#content_save', via: 'patch'
  match '/wargame/web/edit', to: 'web#content_edit', via: 'patch'
  match '/wargame/web/level1', to: 'web#level1', via: [ 'get', 'post' ]
  match '/wargame/web/level2', to: 'web#level2', via: [ 'get', 'post' ]
  match '/wargame/web/level3', to: 'web#level3', via: [ 'get', 'post' ]
  match '/wargame/web/level4', to: 'web#level4', via: [ 'get', 'post' ]
  match '/wargame/web/level5', to: 'web#level5', via: [ 'get', 'post' ]

  match '/wargame/reverse', to: 'reverse#index', via: 'get'
  match '/wargame/reverse/save', to: 'reverse#content_save', via: 'patch'
  match '/wargame/reverse/edit', to: 'reverse#content_edit', via: 'patch'
  match '/wargame/reverse/level1', to: 'reverse#level1', via: [ 'get', 'post' ]
  match '/wargame/reverse/level2', to: 'reverse#level2', via: [ 'get', 'post' ]
  match '/wargame/reverse/level3', to: 'reverse#level3', via: [ 'get', 'post' ]
  match '/wargame/reverse/level4', to: 'reverse#level4', via: [ 'get', 'post' ]
  match '/wargame/reverse/level5', to: 'reverse#level5', via: [ 'get', 'post' ]

  match '/wargame/crypto', to: 'crypto#index', via: 'get'
  match '/wargame/crypto/save', to: 'crypto#content_save', via: 'patch'
  match '/wargame/crypto/edit', to: 'crypto#content_edit', via: 'patch'
  match '/wargame/crypto/level1', to: 'crypto#level1', via: [ 'get', 'post' ]
  match '/wargame/crypto/level2', to: 'crypto#level2', via: [ 'get', 'post' ]
  match '/wargame/crypto/level3', to: 'crypto#level3', via: [ 'get', 'post' ]
  match '/wargame/crypto/level4', to: 'crypto#level4', via: [ 'get', 'post' ]
  match '/wargame/crypto/level5', to: 'crypto#level5', via: [ 'get', 'post' ]

  match '/wargame/pwn', to: 'pwn#index', via: 'get'
  match '/wargame/pwn/save', to: 'pwn#content_save', via: 'patch'
  match '/wargame/pwn/edit', to: 'pwn#content_edit', via: 'patch'
  match '/wargame/pwn/level1', to: 'pwn#level1', via: [ 'get', 'post' ]
  match '/wargame/pwn/level2', to: 'pwn#level2', via: [ 'get', 'post' ]
  match '/wargame/pwn/level3', to: 'pwn#level3', via: [ 'get', 'post' ]
  match '/wargame/pwn/level4', to: 'pwn#level4', via: [ 'get', 'post' ]
  match '/wargame/pwn/level5', to: 'pwn#level5', via: [ 'get', 'post' ]

  match '/user/:id', to: 'users#show', via: 'get', as: :show_user

  devise_for :users, :controllers => { omniauth_callbacks: 'omniauth_callbacks', registrations: 'registrations', sessions: 'sessions' }
  devise_scope :user do
    get "register", :to => "registrations#new"
    get "login", :to => "sessions#new"
    get "logout", :to => "sessions#destroy"
  end
end
