Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  root "home#index"
  resources :cnf_to_dnf, only: %i[index create]
  resources :recurrence_relations, only: %i[index create]
  resources :solving_recurrence_relations, only: %i[index create]
  resource :sets, only: %i[show] do
    resources :difference, only: %i[create]
    resources :union, only: %i[create]
    resources :interception, only: %i[create]
  end

  resource :number_theory, only: %i[show], module: :number_theory do
    resources :modulo, only: %i[create]
    resources :gcd, only: %i[create]
    resources :modulo_inverse, only: %i[create]
    resources :prime_numbers, only: %i[create]
    resources :prime_factorization, only: %i[create]
    scope module: :modular_arithmetic do
      resources :linear_congruence, only: %i[create]
      resources :chinese_remainder_theorem, only: %i[create]
      resources :addition, only: %i[create]
      resources :multiplication, only: %i[create]
      resources :division, only: %i[create]
      resources :exponentiation, only: %i[create]
    end
  end

  resource :hamming_code, only: %i[show], module: :hamming_code do
    resources :encode, only: %i[create]
    resources :decode, only: %i[create]
  end

  resources :calculate_checksum, only: %i[index create]

  resource :graph_theory, only: %i[show], module: :graph_theory do
    resources :number_of_vertices, only: %i[create]
  end

  get 'health-and-fitness', to: 'home#health_and_fitness'
end
