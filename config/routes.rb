Rails.application.routes.draw do
  root 'welcome#index'

  resources :books, param: :book_id
  resources :books, only: [] do
    patch '/upload_cover_image', :action => "upload_cover_image"
    post '/delete_cover_image', :action => "delete_cover_image"
  end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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
end

# ====================================== Routes =========================================================
#                  Prefix Verb   URI Pattern                                  Controller#Action
#                    root GET    /                                            welcome#index
#                   books GET    /books(.:format)                             books#index
#                         POST   /books(.:format)                             books#create
#                new_book GET    /books/new(.:format)                         books#new
#               edit_book GET    /books/:book_id/edit(.:format)               books#edit
#                    book GET    /books/:book_id(.:format)                    books#show
#                         PATCH  /books/:book_id(.:format)                    books#update
#                         PUT    /books/:book_id(.:format)                    books#update
#                         DELETE /books/:book_id(.:format)                    books#destroy
# book_upload_cover_image PATCH  /books/:book_id/upload_cover_image(.:format) books#upload_cover_image
# book_delete_cover_image POST   /books/:book_id/delete_cover_image(.:format) books#delete_cover_image
