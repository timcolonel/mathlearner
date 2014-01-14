module MathLearner

  class AlgorithmParser
    def self.parse(content)
      steps = []
      last_step = nil
      content.gsub!(/\r\n?/, "\n");
      lines = content.split("\n")
      lines.each do |line|
        next if line.empty? or line.blank?
        step = Step.new

        step.parent=last_step
        if steps.size == lines.size-1
          step.output = true
        else
        end
        step.value = line
        last_step = step
        steps << step
      end
      steps
    end
  end
end