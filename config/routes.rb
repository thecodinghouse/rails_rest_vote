Rails.application.routes.draw do
  match 'route' => 'my_gem/samples#index'
end
