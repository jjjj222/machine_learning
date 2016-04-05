require 'matrix'

class KNN
    #@@random_seed = 0
    #@@partition_ratio = 3

    def initialize(examples, attributes, setup)
        @attributes = attributes
        @setup = setup
        @examples = examples.map do |example|
            normalize(example)
        end

        @k = @setup.get_or_else("k", 1)
        @is_weighted = @setup.get_or_else("distance-weighting", false)
        @use_PCA = @setup.get_or_else("PCA", false)
        @energy_ratio = @setup.get_or_else("PCA-energy-ratio", 0.9)

        if @k == -1
            @k = @examples.length
        end

        if @use_PCA
            calculate_pca_matrix()

            @examples = @examples.map do |example|
                transform(example)
                #print example
                #puts
                #new_example = example[0...-1]
                #new_example = Matrix.rows([example[0...-1]])
                #print new_example
                #puts
                #new_example = new_example * @w
                #new_example = new_example.to_a[0] + [example[-1]]
                #print new_example
                #puts
            end
            #@examples.dump
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

    def transform(example)
        #print example
        #puts
        #new_example = example[0...-1]
        new_example = Matrix.rows([example[0...-1]])
        #print new_example
        #puts
        new_example = new_example * @w
        new_example = new_example.to_a[0] + [example[-1]]
        #print new_example
        #puts
        return new_example
    end

    def calculate_pca_matrix
        x_raw = @examples.map do |example| example[0...-1] end

        x = Matrix.rows(x_raw)
        xtx = x.transpose * x

        eigenvalues = xtx.eigen.eigenvalues()
        eigenvectors = xtx.eigen.eigenvectors()

        value_vectors = []
        eigenvalues.each_with_index do |value, i|
            value_vectors << [value, eigenvectors[i]]
        end

        #value_vectors.dump
        value_vectors = value_vectors.sort_by {|value_vector| value_vector[0] * -1}
        #value_vectors.dump

        #vectors.dump
        values = value_vectors.map {|value_vector| value_vector[0]}


        energy_d = values.inject(0.0) {|sum, elt| sum += elt}
        #puts energy_d
        sum = 0.0
        k = 0
        values.each_with_index do |value, i|
            sum += value
            if sum > energy_d * 0.9
                k = i
                break
            end
        end
        #puts k
        #values.dump

        vectors = value_vectors.map {|value_vector| value_vector[1]}
        vectors = vectors[0..k]
        @w = Matrix.columns(vectors)
        #@w.dump
        #values.dump
        #return w
        #puts vectors.length
    end

    def classify(test_example)
        test_example = normalize(test_example)

        if @use_PCA
            test_example = transform(test_example)
        end

        distances = sorted_class(test_example)
        sub_distances = distances[0...@k]
        #print test_example
        #puts
        #sub_distances.dump

        if @is_weighted
            hash = Hash.new(0.0)
            sub_distances.each do |distance|
                hash[distance[-1]] += (1.0 / (distance[0] ** 2))
            end
            return hash.max_by { |k, v| v }[0]
        else
          result = sub_distances.map do |distance|
              distance[-1]
          end.majority
        end
        #puts
        #puts " => #{distances[0][1]}"
        #distances.dump
        #return distances[0][1]
        return result
    end

    def sorted_class(test_example)
        distances = @examples.map do |example|
            [distance(example, test_example), example[-1]]
        end.sort_by do |distance|
            distance[0]
        end
    end

    def distance(example1, example2)
        sum = 0.0
        @attributes.each_with_index do |attribute, i|
            if attribute.continuous?
                sum += (example1[i].to_f - example2[i].to_f) ** 2
            else
                if (example1[i] != example2[i])
                    sum += 1
                end
            end
        end
        Math.sqrt(sum)
    end
end
