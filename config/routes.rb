InvestBrasil::Application.routes.draw do
  root :to => 'home#index'  
  
  # TO-DO
  # ALTERAR NO DEVELOPERS.FACEBOOK.COM 
  # A ROTA DE LOCALHOST:3000 QUANDO SISTEMA FOR PRO AR

  match 'auth/:provider/callback', to: 'sessions#create_with_facebook'
  match 'auth/failure', to: redirect('/')
  match 'signout', to: 'sessions#destroy', as: 'signout'

  resources :companies

  match 'companies/:company_id/create_comment', to: 'companies#create_comment', as: 'create_comment'
  match 'companies/:company_id/:comment_id/create_subcomment', to: 'companies#create_subcomment', as: 'create_subcomment'

  match 'companies/:company_id/follow_company', to: 'users#follow_company', as: 'follow_company'
  match 'companies/:company_id/unfollow_company', to: 'users#unfollow_company', as: 'unfollow_company'

  get 'log_in' => 'sessions#new', :as => 'log_in'
  get 'sign_up' => 'users#new', :as => 'sign_up'  
  resources :users
  resources :sessions

   match "/companies_ajax" => "companies#companies_ajax"

end