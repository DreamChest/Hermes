Rails.application.routes.draw do
  namespace :v1 do
    resources :sources do
      resources :articles, only: %i[show index] do
        resource :content, only: :show
      end

      resources :tags, only: %i[show index]
    end

    get '/sources/:id/update', to: 'sources#update_articles'
    get '/sources/:id/clear', to: 'sources#clear'
    get '/sources/:id/reset', to: 'sources#reset'

    resources :articles, only: %i[show index] do
      resource :content, only: :show
    end

    get '/tags/clean', to: 'tags#clean'
    resources :tags do
      resources :sources, only: %i[show index] do
        resources :articles, only: %i[show index] do
          resource :content, only: :show
        end
      end
    end

    post 'authenticate', to: 'authentication#authenticate'
  end
end
