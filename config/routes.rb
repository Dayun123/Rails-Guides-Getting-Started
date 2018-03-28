Rails.application.routes.draw do
  get 'welcome/index'

  # creates a nested resource where paths to comments are prefixed by the article they belong to. This is a neccessary step to take after setting up an association between articles and comments where an article has_many comments and a comment belongs_to an article.
  resources :articles do
    resources :comments
  end

  root 'welcome#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
