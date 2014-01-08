class WelcomeController < ApplicationController
  def index
    @query = params[:query]
    if @query.nil?
      return
    end
    q_p = Parser::Tree.new(@query).parse
    @parsed = ''
    enum = Parser::FunctionNodeEnumerator.new(q_p)
    @parsed += enum.next.to_s + "\n"
    @parsed += enum.next.to_s + "\n"
    @parsed += enum.next.to_s + "\n"
    @parsed += enum.next.to_s + "\n"
    @parsed += enum.next.to_s + "\n"
    @parsed += enum.next.to_s + "\n"
    @parsed += enum.next.to_s + "\n"
  end
end
