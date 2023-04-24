Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/doctors/:id', to: 'doctors#show'
  delete '/doctors/:id', to: 'doctors#destroy'

  get '/patients', to: 'patients#index'
end
