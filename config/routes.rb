class StaticConstraint
   def matches?(request)
      request.url.include?("_escaped_fragment_")
   end
end

YourApp::Application.routes.draw do
  get '/', to: 'static#show', constraints: StaticConstraint.new
  get '*path', to: 'static#show', constraints: StaticConstraint.new
end
