Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: "users/sessions" }, skip: [:registrations, :passwords]

  get "up" => "rails/health#show", as: :rails_health_check

  root "pages#home"
  get "about", to: "pages#about"
  get "services", to: "pages#services"
  get "contact", to: "pages#contact"
  resources :contact_messages, only: :create
  resources :posts, only: %i[index show], param: :id
  get "pages/:slug", to: "site_pages#show", as: :site_page

  namespace :controlpanel do
    root to: "dashboard#index"
    resource :general_settings, only: %i[edit update], path: "general"
    resource :appearance_settings, only: %i[edit update], path: "appearance"
    resource :contact_settings, only: %i[edit update], path: "contact"
    resource :seo_settings, only: %i[edit update], path: "seo"
    resources :site_pages do
      member do
        patch :publish
        patch :unpublish
      end
    end
    resources :posts do
      member do
        patch :publish
        patch :unpublish
      end
    end
    resources :contact_messages, only: %i[index show update destroy]
    resources :media, only: %i[index destroy]
  end
end
