Rails.application.routes.draw do
  resources :sources do
    resources :articles, only: %i[show index] do
      resource :content, only: :show
    end

    resources :tags, only: %i[show index]
  end

  get '/sources/:id/update_entries', to: 'sources#update_entries'

  resources :articles, only: %i[show index] do
    resource :content, only: :show
  end

  resources :tags

  post 'authenticate', to: 'authentication#authenticate'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
