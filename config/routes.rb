Rails.application.routes.draw do
  
  root 'items#home'
  get 'items/new'
  post 'result' =>'items#result'

#post 'show' => 'activityposts#show'
end
