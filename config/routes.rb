Rails.application.routes.draw do
  root 'applicants#index'
  
  resources :applicants
end
