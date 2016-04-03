class KNN
    #@@random_seed = 0
    #@@partition_ratio = 3

    def initialize(examples, attributes, setup)
        @attributes = attributes
        @setup = setup
        @examples = examples.map do |example|
            normalize(example)
        end
    end

    def normalize(example)
        res = []

        @attributes.each_with_index do |attribute, i|
            if (example[i] != "?" and attribute.continuous?)
                res << (example[i].to_f - attribute.mean) / attribute.se
            else
                res << example[i]
            end
        end

        return res
    end

    def classify(test_example)
        distances = sorted_class(test_example)

        #print test_example
        #puts " => #{distances[0][1]}"
        #print @setup

        return distances[0][1]
    end

    def sorted_class(test_example)
        test_example = normalize(test_example)
        distances = @examples.map do |example|
            [distance(example, test_example), example[-1]]
        end.sort_by do |distance|
            distance[0]
        end
    end

    def distance(example1, example2)
        sum = 0.0
        @attributes.each_with_index do |attribute, i|
            sum += (example1[i].to_f - example2[i].to_f) ** 2
        end
        Math.sqrt(sum)
    end
end
