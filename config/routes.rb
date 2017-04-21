Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :lists do
    resources :items
  end

  root 'lists#index'
end
