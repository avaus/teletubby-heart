TeletubbyHeart::Application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'

  resources :channels do
    member do
      put 'set_as_default'
      get 'watch'
      get 'next_slide'
    end
    resources :channel_slides, path: "slides", as: "slides"
  end

  resources :slides
  match '/slides/update_type_selection/:type', :controller=>'slides', :action=>'update_type_selection'

  match "/about" => "dashboard#about"
  match "/help" => "dashboard#help"

  match "/templates(/default)" => "templates#default"
  match "/templates/graph" => "templates#graph"
  match "/templates/show/:html" => "templates#show"

  match "/client" => "client#index"
  match "/clients" => "client#list"
  match "/client/:id/destroy" => "client#destroy"
  match "/client/destroy_inactive_clients" => "client#destroy_inactive_clients"
  match '/client/:id/switch_channel' => 'client#switch_channel', via: :put

  root :to => 'dashboard#home'
  get '/dashboard/home'
end
