Rails.application.routes.draw do
  resources :companies
  resources :contacts

  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
    get "view", to: "pages#view"
    resources :tickets, only: [:new, :create,:index, :show, :edit, :update]  do
      collection do
        get :show_ticket
      end
    end
    resources :messages, only: [:new, :create, :index] do
      collection do
        delete :clear
      end
    end


  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.


  # Defines the root path route ("/")
  # root "posts#index"
end
