TeletubbyHeart::Application.routes.draw do
  resources :channels do
    member do
      put 'set_as_default'
      get 'watch'
      get 'next_slide'
    end
    resources :channel_slides, path: "slides", as: "slides"
  end

  resources :slides

  match "/about" => "dashboard#about"
  match "/help" => "dashboard#help"

  match "/templates(/default)" => "templates#default"
  match "/templates/graph" => "templates#graph"

  match "/client" => "client#index"
  match "/clients" => "client#list"
  match '/client/:id/switch_channel' => 'client#switch_channel', via: :put

  root :to => 'dashboard#home'
  get '/dashboard/home'
end
