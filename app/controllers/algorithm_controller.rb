class AlgorithmController < ApplicationController

  def new
    @code = ''
  end

  def create
    @name = params[:name]
    @code = params[:content]
    if @code.nil? or @name.nil?
      render :new
    else
      steps = MathLearner::AlgorithmParser.parse(@code)
      algorithm = Algorithm.new
      algorithm.steps = steps
      algorithm.name = @name
      algorithm.save
      redirect_to use_algorithm_path
    end
  end


  def use
    if params[:algorithm].nil?
      @query = ''
    else
      @algorithm = Algorithm.find(params[:algorithm])
      @query = params[:query]

      query_tree = MathLearner::Tree.new(@query).parse
      input = MathLearner::Tree.new(@algorithm.input.value).parse
      output = MathLearner::Tree.new(@algorithm.outputs.first.value).parse

      matcher = MathLearner::Matcher.new
      match = matcher.match(query_tree, input)
      if match.nil?
        @parsed = "Wrong input format for algorithm `#{@algorithm.name}`, need: `#{@algorithm.input.value}`"
      else
        @parsed = MathLearner::Matcher.transform(output, matcher.mapping).tree.get_element.to_readable
      end
    end
  end

  def match
    input1 = MathLearner::Tree.new(params[:input1])
    input2 = MathLearner::Tree.new(params[:input2])

    
  end
end
