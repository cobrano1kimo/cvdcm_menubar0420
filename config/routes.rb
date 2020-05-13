Rails.application.routes.draw do

  resources :user_groups
  resources :customers
  resources :accounts, only: [:index,:create,:destroy]
  devise_for :users, only: [:sessions]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  scope :controller => "accounts", :path => "/accounts" do

    get 'accounts', :to => "accounts#edit", as: "invoices"
    post 'accounts', :to =>"accounts#edit" , as: "acinvoices"
  end


  scope "(:locale)", locale: /zh_TW|en/ do
    root "menubars#show_menu"
    resources :menubars, param: :menu_id do
      collection do
        get :show_menu
        post :reset, :search
      end
      member do
        get :form
      end
    end
  end


  # bar_meeting GET   /foo/meetings/:id(.:format) events#show
  # bar_meetings POST /foo/meetings(.:format)     events#create
end
