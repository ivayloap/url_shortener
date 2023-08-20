Rails.application.routes.draw do
  post '/encode', to: 'urls_mappings#encode'
  post '/decode', to: 'urls_mappings#decode'
end