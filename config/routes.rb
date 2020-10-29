Rails.application.routes.draw do

  resources :histories
  resources :user_groups
  resources :customers, only: [:index,:destroy]
  resources :accounts, only: [:index,:destroy]
  devise_for :users, only: [:sessions]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
   #account
  scope :controller => "accounts", :path => "/accounts" do

    get 'accounts', :to => "accounts#edit", as: "invoices"
    post 'accounts', :to =>"accounts#edit" , as: "acinvoices"
  end
  scope :controller => "accounts", :path => "/colse" do

    get 'accounts', :to => "accounts#colse_edit", as: "invoicesclo"
    post 'accounts', :to =>"accounts#colse_edit" , as: "acinvoicesclo"
  end
  scope :controller => "accounts", :path => "/open" do

    get 'accounts', :to => "accounts#open_edit", as: "invoicesope"
    post 'accounts', :to =>"accounts#open_edit" , as: "acinvoicesope"
  end
  scope :controller => "accounts", :path => "/new" do

    get 'accounts', :to => "accounts#new", as: "ninvoices"
    post 'accounts', :to =>"accounts#new" , as: "nacinvoices"
  end
  scope :controller => "accounts", :path => "/create" do

    get 'accounts', :to => "accounts#create", as: "cinvoices"
    post 'accounts', :to =>"accounts#create" , as: "cacinvoices"
  end

  scope :controller => "accounts", :path => "/query" do

    get 'accounts', :to => "accounts#query" ,as: "qinvoices"
    post 'accounts', :to =>"accounts#query" ,as: "qacinvoices"
  end
  scope :controller => "accounts", :path => "/printe" do

    get 'accounts', :to => "accounts#printe" ,as: "einvoices"
    post 'accounts', :to =>"accounts#printe" ,as: "eacinvoices"
  end
  scope :controller => "accounts", :path => "/printp" do

    get 'accounts', :to => "accounts#printp" ,as: "pinvoices"
    post 'accounts', :to =>"accounts#printp" ,as: "pacinvoices"

  end
  scope :controller => "accounts", :path => "/resultp" do

    get 'accounts', :to => "accounts#resultp" ,as: "rpinvoices"
    post 'accounts', :to =>"accounts#resultp" ,as: "rpacinvoices"
  end
  scope :controller => "accounts", :path => "/resulte" do

    get 'accounts', :to => "accounts#resulte" ,as: "reinvoices"
    post 'accounts', :to =>"accounts#resulte" ,as: "reacinvoices"
  end
  scope :controller => "accounts", :path => "/resultp1" do

    get 'accounts', :to => "accounts#resultp1" ,as: "rp1invoices"
    post 'accounts', :to =>"accounts#resultp1" ,as: "rp1cinvoices"
  end
  scope :controller => "accounts", :path => "/printp1" do

    get 'accounts', :to => "accounts#printp1" ,as: "p1invoices"
    post 'accounts', :to =>"accounts#printp1" ,as: "p1cinvoices"
  end
  #customer
  scope :controller => "customers", :path => "/customers" do

    get 'customers', :to => "customers#edit",as:"mantaincust"
    post 'customers', :to =>"customers#edit",as:"mpantaincust"
  end

  scope :controller => "customers", :path => "/new" do

    get 'customers', :to => "customers#new",as:"nmantaincust"
    post 'customers', :to =>"customers#new",as:"npantaincust"
  end
  scope :controller => "customers", :path => "/create" do

    get 'customers', :to => "customers#create",as:"cnmantaincust"
    post 'customers', :to =>"customers#create",as:"cnpantaincust"
  end
  scope :controller => "customers", :path => "/query" do

    get 'customers', :to => "customers#query",as:"qnmantaincust"
    post 'customers', :to =>"customers#query",as:"qnpantaincust"
  end
  scope :controller => "histories", :path => "/query" do

    get 'histories', :to => "histories#query",as:"gquery_history"
    post 'histories', :to =>"histories#query",as:"pquery_history"
  end
  scope :controller => "user_groups", :path => "/query" do

    get 'user_groups', :to => "user_groups#query",as:"gquery_user_groups"
    post 'user_groups', :to =>"user_groups#query",as:"pquery_user_groups"
  end


  # scope :controller => "accounts", :path => "/download" do
  #   post 'accounts', :to =>"accounts#download_pdf",as: "dpacinvoices"
  # end


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
