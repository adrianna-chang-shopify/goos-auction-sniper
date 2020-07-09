Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :snipers, only: %i[new create index] do
    member do
      post :callback
    end
  end
end
