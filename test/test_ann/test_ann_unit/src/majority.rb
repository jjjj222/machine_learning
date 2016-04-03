require "./src/util.rb"

class Majority
    attr_reader :class

    def initialize(examples, attributes = nil, setup = nil)
        @class = examples.transpose[-1].majority
    end

    def classify(example)
        return @class
    end
end
