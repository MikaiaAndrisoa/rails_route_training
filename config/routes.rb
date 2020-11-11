Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users do
    member do
      resources :comments, controller: 'users/comments'
      resources :articles, controller: 'users/articles'
    end
  end

  resources :articles do
    resources :comments, controller: 'articles/comments'
    resources :users, controller: 'articles/users', only: [:index]
  end

  resources :books do
    member do
      resources :articles, controller: 'books/articles', only: [:index]
    end
  end
end
