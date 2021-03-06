Toruzou::Application.routes.draw do

  scope :api do
    scope :v1 do
      devise_for :users
    end
  end

  namespace :api, defaults: { format: "json" } do
    namespace :v1 do
      get "account" => "account#show"
      put "account" => "account#update"
      get "account/followings" => "account#followings"
      put "account/password" => "account#change_password"
      resources :notes
      resources :changelogs
      resources :notifications
      resources :attachments
      resources :sales_projections, :path => "sales"
      resources :users do
        member do
          get "followings" => "users#followings"
          put "following" => "users#follow"
          delete "following" => "users#unfollow"
        end
        resources :notes
      end
      resources :organizations do
        member do
          put "following" => "organizations#follow"
          delete "following" => "organizations#unfollow"
        end
        resources :notes
        resources :attachments
      end
      resources :people do
        member do
          put "following" => "people#follow"
          delete "following" => "people#unfollow"
        end
        resources :notes
        resources :attachments
        resources :careers
      end
      resources :deals do
        member do
          put "following" => "deals#follow"
          delete "following" => "deals#unfollow"
        end
        resources :notes
        resources :attachments
        resources :sales_projections, :path => "sales"
      end
      resources :activities do
        resources :attachments
        resources :notes
      end
      resources :careers do
        resources :notes
        resources :attachments
      end
    end
  end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'index#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end
  
  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # Workaround for development
  regex = /(^\/rails\/info\/.*)|(\.(html|js|css|swf|jp(e?)g|png|gif|eot|svg|ttf|woff|otf)$)/
  get "*path", :to => "index#index", :constraints => lambda { |req| !req.path.match regex }

end
