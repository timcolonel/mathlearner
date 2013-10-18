class WelcomeController < ApplicationController
  def index
    query = params[:query]
    query ||= ''
    @parsed = Parser::Element.new(query).parse
  end
end
