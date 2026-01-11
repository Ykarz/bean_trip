Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  root "static#top"

  # 豆診断機能へのルーティング
  resources :diagnoses, only: %i[new create show]

  # 豆検索・豆投稿機能へのルーティング
  resources :beans, only: %i[index new create show edit update destroy]

  # 店舗検索機能へのルーティング
  resources :stores, only: %i[index show]

  # 'devise'の各種コントローラへのルーティング
  devise_for :users,
            path: "",
            path_names: { sign_in: 'login', sign_out: 'logout' }

  # ユーザープロフィール機能へのルーティング
  resource :profile, only: %i[show edit update]
end
