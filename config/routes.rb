Rails.application.routes.draw do
  
  root 'items#home'
  post 'result' =>'items#result'

end
