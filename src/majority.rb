require "./src/data.rb"
require "./src/util.rb"
require "./src/statistics.rb"

class Majority
    attr_reader :class

    def initialize(examples, attributes, setup)
        @class = examples.transpose[-1].word_count.max_by { |k, v| v }[0]
    end

    def classify(example)
        return @class
    end
end
