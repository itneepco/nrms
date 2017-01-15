Rails.application.routes.draw do
  get 'dashboard' => 'dashboard#index'

  get 'session/new'

  resources :categories
  resources :projects do
    resources :risk_registers
  end
  resources :risk_registers, only: [] do
    resources :risk_mitigations    
  end
  resources :users
  resources :designations
  
  get 'login' => 'session#new'
  post 'login' => 'session#create'
  get 'logout' => 'session#destroy'
  get 'get_risks' => "risk_mitigations#get_risks"

  root 'dashboard#index'
end
