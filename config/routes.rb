Openbama::Application.routes.draw do

  get "api/index"

  get "api/sessions"

  get "api/bills"

  get "api/legislators"

  get "page/index"

  get "blog/index"

  get "lobbyist/index"

  get "clients/index"

  get "client/index"

  get "subjects/index"

  get "subject/index"

  get "tag/index"

  get "vote/index"

  get "legislator/index"

  get "votes/index"

  get "about/index"

  get "bill/index"

  get "home/index"

  get "api/bill_status"
  get "committees/meetings"
  
  root :to => "home#index"
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


	match "bills/:session/:bill_type/:number" => "bills#detail"
	match "bills/" => "bills#index"
	match "bills/index" => "bills#index"
	match "bills/:session" => "bills#index"
	match "bills/index/:session" => "bills#index"
  match "bill/:id" => "bill#detail"
  #match "bill/index" => "bills#index"
  match "bill/" => "bills#index"
  match "bill/index/:id" => "bill#detail"
	match "about/" => "about#index"
	match "legislators/" =>  "legislators#index"
	match "votes/" => "votes#index"
	match "legislator/:id" => "legislator#index"
	match "legislator/index/:id" => "legislator#index"
	match "vote/:id" => "vote#index"
	match "vote/index/:id" => "vote#index"
	match "subject/:id" => "subject#index"
	match "subject/index/:id" => "subject#index"
	match "bill/:id/text" => "bill#text"
	match "bill/index/:id/text" => "bill#text"
	match "bill/:id/add_tag" => 'bill#add_tag'
	match "bill/:id/vote_yes" => 'bill#vote_yes'
	match "bill/:id/vote_no" => 'bill#vote_no'
	match "tag/:id" => "tag#index"
	match "tag/index/:id" => "tag#index"
	match "legislator/:id/rate" => "legislator#rate"
	match "sponsor/:id/" => "sponsor#index"
	match "sponsor/index/:id/" => "sponsor#index"
	match "sponsor/:id/:session" => "sponsor#index"
	match "sponsor/index/:id/:session" => "sponsor#index"
# Old OpenBama links
	match "index.php/bill/display/:id" => "bill#detail"
	match "index.php/person/display/:id" => "legislator#index"
	match "index.php/bill/fulltext/:id" => "bill#text"
	match "index.php/committee/display/:id" => "committee#index"
	match "index.php/vote/display/:id" => "vote#index"
# end Old OpenBama links
	match "committees/index" => "committees#index"
	match "committees/" => "committees#index"
	match "committee/index/:id" => "committee#index"
	match "committee/:id" => "committee#index"
	match "lobbyists/" => "lobbyists#index"
	match "lobbyists/index" => "lobbyists#index"
	match "client/:id" => "client#index"
	match "client/index/:id" => "client#index"
	match "clients/" => "clients#index"
	match "lobbyist/:id" => "lobbyist#index"
	match "lobbyist/index/:id" => "lobbyist#index"
	match "legislators/index" => "legislators#index"
	match "blog/" => "blog#index"
	match "blog/:year/:month/:slug" => "blog#post"
	match "blog/:year/:month" => "blog#archive"
	match "page/:uri" => "page#index"
	match "api/" => "api#index"
	match "api/bill/:id" => "api#bill"
	match "api/legislator/:id" => "api#legislator"
	match "api/lobbyists/:year" => "api#lobbyists"
	match "api/lobbyist/:id" => "api#lobbyist"
  match "legislator/:id/votes" => "legislator#votes"
  match "blog/feed" => "blog#feed"
  match "api/bill_status/:bill_type/:bill_number" => "api#bill_status"

  unless Rails.application.config.consider_all_requests_local
    match '*not_found', to: 'errors#error_404'
  end
end
