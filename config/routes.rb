Rails.application.routes.draw do

  devise_for :users

  resources :items

  resources :meals
  
  resources :users do 
    resources :profiles
    resources :recipes do 
      resources :ingredients
    end
  end




  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".
 

  # You can have the root of your site routed with "root"
  root 'profiles#index'




##############################################################################
#                                                                            #
#                           ROUTES                                           #
#                                                                            #
##############################################################################


#               Prefix Verb   URI Pattern                                                              Controller#Action
#---------------------------------------------------------------------------------------------------------------------------
#            new_user_session GET    /users/sign_in(.:format)                                          devise/sessions#new
#                user_session POST   /users/sign_in(.:format)                                          devise/sessions#create
#        destroy_user_session DELETE /users/sign_out(.:format)                                         devise/sessions#destroy
#               user_password POST   /users/password(.:format)                                         devise/passwords#create
#           new_user_password GET    /users/password/new(.:format)                                     devise/passwords#new
#          edit_user_password GET    /users/password/edit(.:format)                                    devise/passwords#edit
#                             PATCH  /users/password(.:format)                                         devise/passwords#update
#                             PUT    /users/password(.:format)                                         devise/passwords#update
#    cancel_user_registration GET    /users/cancel(.:format)                                           devise/registrations#cancel
#           user_registration POST   /users(.:format)                                                  devise/registrations#create
#       new_user_registration GET    /users/sign_up(.:format)                                          devise/registrations#new
#      edit_user_registration GET    /users/edit(.:format)                                             devise/registrations#edit
#                             PATCH  /users(.:format)                                                  devise/registrations#update
#                             PUT    /users(.:format)                                                  devise/registrations#update
#                             DELETE /users(.:format)                                                  devise/registrations#destroy
#                       items GET    /items(.:format)                                                  items#index
#                             POST   /items(.:format)                                                  items#create
#                    new_item GET    /items/new(.:format)                                              items#new
#                   edit_item GET    /items/:id/edit(.:format)                                         items#edit
#                        item GET    /items/:id(.:format)                                              items#show
#                             PATCH  /items/:id(.:format)                                              items#update
#                             PUT    /items/:id(.:format)                                              items#update
#                             DELETE /items/:id(.:format)                                              items#destroy
#                       meals GET    /meals(.:format)                                                  meals#index
#                             POST   /meals(.:format)                                                  meals#create
#                    new_meal GET    /meals/new(.:format)                                              meals#new
#                   edit_meal GET    /meals/:id/edit(.:format)                                         meals#edit
#                        meal GET    /meals/:id(.:format)                                              meals#show
#                             PATCH  /meals/:id(.:format)                                              meals#update
#                             PUT    /meals/:id(.:format)                                              meals#update
#                             DELETE /meals/:id(.:format)                                              meals#destroy
#               user_profiles GET    /users/:user_id/profiles(.:format)                                profiles#index
#                             POST   /users/:user_id/profiles(.:format)                                profiles#create
#            new_user_profile GET    /users/:user_id/profiles/new(.:format)                            profiles#new
#           edit_user_profile GET    /users/:user_id/profiles/:id/edit(.:format)                       profiles#edit
#                user_profile GET    /users/:user_id/profiles/:id(.:format)                            profiles#show
#                             PATCH  /users/:user_id/profiles/:id(.:format)                            profiles#update
#                             PUT    /users/:user_id/profiles/:id(.:format)                            profiles#update
#                             DELETE /users/:user_id/profiles/:id(.:format)                            profiles#destroy
#     user_recipe_ingredients GET    /users/:user_id/recipes/:recipe_id/ingredients(.:format)          ingredients#index
#                             POST   /users/:user_id/recipes/:recipe_id/ingredients(.:format)          ingredients#create
#  new_user_recipe_ingredient GET    /users/:user_id/recipes/:recipe_id/ingredients/new(.:format)      ingredients#new
# edit_user_recipe_ingredient GET    /users/:user_id/recipes/:recipe_id/ingredients/:id/edit(.:format) ingredients#edit
#      user_recipe_ingredient GET    /users/:user_id/recipes/:recipe_id/ingredients/:id(.:format)      ingredients#show
#                             PATCH  /users/:user_id/recipes/:recipe_id/ingredients/:id(.:format)      ingredients#update
#                             PUT    /users/:user_id/recipes/:recipe_id/ingredients/:id(.:format)      ingredients#update
#                             DELETE /users/:user_id/recipes/:recipe_id/ingredients/:id(.:format)      ingredients#destroy
#                user_recipes GET    /users/:user_id/recipes(.:format)                                 recipes#index
#                             POST   /users/:user_id/recipes(.:format)                                 recipes#create
#             new_user_recipe GET    /users/:user_id/recipes/new(.:format)                             recipes#new
#            edit_user_recipe GET    /users/:user_id/recipes/:id/edit(.:format)                        recipes#edit
#                 user_recipe GET    /users/:user_id/recipes/:id(.:format)                             recipes#show
#                             PATCH  /users/:user_id/recipes/:id(.:format)                             recipes#update
#                             PUT    /users/:user_id/recipes/:id(.:format)                             recipes#update
#                             DELETE /users/:user_id/recipes/:id(.:format)                             recipes#destroy
#                       users GET    /users(.:format)                                                  users#index
#                             POST   /users(.:format)                                                  users#create
#                    new_user GET    /users/new(.:format)                                              users#new
#                   edit_user GET    /users/:id/edit(.:format)                                         users#edit
#                        user GET    /users/:id(.:format)                                              users#show
#                             PATCH  /users/:id(.:format)                                              users#update
#                             PUT    /users/:id(.:format)                                              users#update
#                             DELETE /users/:id(.:format)                                              users#destroy
#                        root GET    /                                                                 profiles#index








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