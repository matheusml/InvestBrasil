InvestBrasil::Application.routes.draw do
  root :to => 'home#index'  
  
  # TO-DO
  # ALTERAR NO DEVELOPERS.FACEBOOK.COM 
  # A ROTA DE LOCALHOST:3000 QUANDO SISTEMA FOR PRO AR

  match 'auth/:provider/callback', to: 'sessions#create'
  match 'auth/failure', to: redirect('/')
  match 'signout', to: 'sessions#destroy', as: 'signout'

  resources :companies

  match 'companies/:company_id/create_comment', to: 'companies#create_comment', as: 'create_comment'
  match 'companies/:company_id/:comment_id/create_subcomment', to: 'companies#create_subcomment', as: 'create_subcomment'

end