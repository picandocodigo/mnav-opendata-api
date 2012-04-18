Museum::Application.routes.draw do
  get "/artist/:id"          => "artist#show", :constraints => {:format => /(json|xml)/}, :defaults => { :format => 'json' }
  get "/artist/:id/artworks" => "artist#artist_artworks", :constraints => {:format => /(json|xml)/}, :defaults => { :format => 'json' }
  get "/artists"             => "artist#index", :constraints => {:format => /(json|xml)/}, :defaults => { :format => 'json' }
  get "/artwork/:id"         => "artwork#show", :constraints => {:format => /(json|xml)/}, :defaults => { :format => 'json' }
  get "/artworks"            => "artwork#index", :constraints => {:format => /(json|xml)/}, :defaults => { :format => 'json' }
  
  
end
