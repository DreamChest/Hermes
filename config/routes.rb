Rails.application.routes.draw do
  # V1 API
  namespace :v1 do
    # Sources routes
    resources :sources do
      resources :articles, only: %i[show index]
      resources :tags, only: %i[show index]

      member do
        get 'update' => 'sources#update_articles'
        get 'clear'
        get 'reset'
      end
    end

    # Articles routes
    resources :articles, only: %i[show index] do
      resource :content, only: :show
    end

    # Tags routes
    get '/tags/clean'
    resources :tags do
      resources :sources, only: %i[show index]
      resources :articles, only: %i[show index]
    end

    post 'authenticate' => 'authentication#authenticate'
  end
end
