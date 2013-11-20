class WelcomeController < ApplicationController
  def index
    @query = params[:query]
    @query ||= ''
    q_p = Parser::Tree.new(@query).parse
    f_p = Parser::Tree.new('a*(c+d)').parse

    develop = Algorithm.find(2)
    input = Parser::Tree.new(develop.input).parse
    output = Parser::Tree.new(develop.output).parse

    puts '-------------------------'
    puts 'q: ' + q_p.to_s
    puts 'in: ' + input.to_s
    puts 'out: ' + output.to_s

    match = Matcher::Matcher.match(q_p, input)
    @parsed = Matcher::Matcher.transform(output, match.mapping).tree.get_element.to_readable
  end
end
