Rails.application.routes.draw do
  resources :posts, defaults: { format: :json }, only: [ :index, :show, :create, :update, :destroy ]
  post 'posts/:id', action: :add_comment, controller: 'posts', as: 'add_comment'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
