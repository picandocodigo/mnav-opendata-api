Museum::Application.routes.draw do

  resources :artists, :only => [:index, :show], :constraints => {:format => /(json|xml)/}, :defaults => { :format => 'json'} do
     resources :artworks, :only => [:index], :constraints => {:format => /(json|xml)/}, :defaults => { :format => 'json'}
  end

  resources :artworks, :only => [:index, :show], :constraints => {:format => /(json|xml)/}, :defaults => { :format => 'json'}

end
