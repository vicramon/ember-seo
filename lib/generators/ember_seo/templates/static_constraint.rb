module Constraint
  class Static
    def matches?(request)
      request.url.include?("_escaped_fragment_")
    end
  end
end
