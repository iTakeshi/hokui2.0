Hokui::Application.routes.draw do

  get "index/index"

  get  '/signup', to: 'users#new'
  post '/signup', to: 'users#create'

  get '/users/confirm/:user_auth_token', to: 'users#confirm_email'
  get '/users', to: 'users#index'
  get '/users/approve/:id', to: 'users#approve'
  get '/users/reject/:id', to: 'users#reject'
  get '/users/demote/:id', to: 'users#demote'
  get '/users/promote/:id', to: 'users#promote'
  get '/users/delete/:id', to: 'users#delete'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#delete'

  get '/reset_password', to: 'users#forget_password'
  post '/reset_password', to: 'users#reset_password'
  get '/set_new_password/:user_auth_token/:user_secret_token', to: 'users#set_new_password'
  post '/set_new_password/:user_auth_token', to: 'users#create_new_password'

  get '/edit_profile', to: 'users#edit'
  put '/edit_profile', to: 'users#update'
  get '/edit_password', to: 'users#edit_password'
  post '/edit_password', to: 'users#update_password'

  get '/terms/new', to: 'terms#new'
  post '/terms/new', to: 'terms#create'
  get '/terms/:term_identifier/edit', to: 'terms#edit'
  post '/terms/:term_identifier/edit', to: 'terms#update'
  get '/terms', to: 'terms#index'
  get '/terms/:term_identifier/img/:file_name', to: 'terms#download_timetable_img'
  get '/terms/:term_identifier/thumb/:file_name', to: 'terms#download_timetable_thumb'

  get '/terms/:term_identifier/subjects/new', to: 'subjects#new'
  post '/terms/:term_identifier/subjects/new', to: 'subjects#create'
  get '/terms/:term_identifier/subjects/:subject_identifier/edit', to: 'subjects#edit'
  put '/terms/:term_identifier/subjects/:subject_identifier/edit', to: 'subjects#update'

  get '/study', to: 'study#help'
  get '/study/:term_identifier', to: 'study#term'
  get '/study/:term_identifier/:subject_identifier', to: 'study#subject'
  get '/study/:term_identifier/:subject_identifier/syllabus.html', to: 'subjects#download_syllabus_html'
  get '/study/:term_identifier/:subject_identifier/new_exam_file', to: 'materials#new_exam'
  post '/study/:term_identifier/:subject_identifier/new_exam_file', to: 'materials#create'
  get '/study/:term_identifier/:subject_identifier/new_quiz_file', to: 'materials#new_quiz'
  post '/study/:term_identifier/:subject_identifier/new_quiz_file', to: 'materials#create'
  get '/study/:term_identifier/:subject_identifier/new_summary_file', to: 'materials#new_summary'
  post '/study/:term_identifier/:subject_identifier/new_summary_file', to: 'materials#create'
  get '/study/:term_identifier/:subject_identifier/new_personal_file', to: 'materials#new_personal'
  post '/study/:term_identifier/:subject_identifier/new_personal_file', to: 'materials#create'

  get '/materials/:material_id/download/:material_file_name', to: 'materials#download'
  get '/materials/:material_id/edit', to: 'materials#edit'
  put '/materials/:material_id/edit', to: 'materials#update'
  get '/materials/delete/:material_id', to: 'materials#delete'

  get '/freeml/batch', to: 'freeml#batch'

  get '/admin', to: 'admin#index'

  root to: 'index#index'

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
