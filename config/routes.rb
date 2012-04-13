Museum::Application.routes.draw do
  get "/artist/:id"          => "mnav#artist", :constraints => {:format => /(json|xml)/}, :defaults => { :format => 'json' }
  get "/artist/:id/artworks" => "mnav#artist_artworks", :constraints => {:format => /(json|xml)/}, :defaults => { :format => 'json' }
  get "/artwork/:id"         => "mnav#artwork", :constraints => {:format => /(json|xml)/}, :defaults => { :format => 'json' }
  get "/artists"             => "mnav#artists", :constraints => {:format => /(json|xml)/}, :defaults => { :format => 'json' }
  get "/artworks"            => "mnav#artworks", :constraints => {:format => /(json|xml)/}, :defaults => { :format => 'json' }
end
