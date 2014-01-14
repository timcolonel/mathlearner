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
      match = @algorithm.use(query_tree)
      if match.nil?
        @parsed = "Wrong input format for algorithm `#{@algorithm.name}`, need: `#{@algorithm.input.value}`, input is `#{query_tree.to_readable}`"
      else
        @parsed = match.last.value_tree.to_readable.to_s + ' , input was: ' + query_tree.to_readable
      end
    end
  end

  def match
    input1 = MathLearner::Tree.new(params[:input1])
    input2 = MathLearner::Tree.new(params[:input2])

    
  end
end
