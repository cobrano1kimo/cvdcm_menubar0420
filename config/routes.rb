Rails.application.routes.draw do

  devise_for :users, only: [:sessions]
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
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

end
