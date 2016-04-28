require 'matrix'
#require 'byebug'

class KNN
    @@random_seed = 0
    #@@partition_ratio = 3

    def initialize(examples, attributes, setup)
        @attributes = attributes
        @setup = setup
        @examples = examples.map do |example|
            normalize(example)
        end

        @k = @setup.get_or_else("k", 1)
        @is_weighted = @setup.get_or_else("distance-weighting", false)
        @feature_weighting = @setup.get_or_else("feature-weighting", nil)
        @use_PCA = @setup.get_or_else("PCA", false)
        @energy_ratio = @setup.get_or_else("PCA-energy-ratio", 0.9)
        @use_ntgrowth = @setup.get_or_else("NTGrowth", false)
        @nt_drop_ratio = @setup.get_or_else("NTGrowth-drop-ratio", 0.75)

        if @k == -1
            @k = @examples.length
        end

        if @feature_weighting
            @feature_weighting = calculate_feature_weighting()
            if @feature_weighting
              puts "Feature weighting:"
              @attributes[0...-1].each_with_index do |attribute, i|
                  puts "#{attribute.name} : #{@feature_weighting[i]}"
              end
            end
        end

        if @use_PCA and @attributes[0...-1].detect {|attribute| !attribute.continuous?}
            @use_PCA = false
            puts "Note: PCA is off due to non-continuous attributes"
        end

        if @use_PCA
            calculate_pca_matrix()

            @examples = @examples.map do |example|
                transform(example)
            end
        end

        if @use_ntgrowth
            nt_growth()
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

    def nt_growth
        old_examples = @examples.shuffle!(random: Random.new(@@random_seed))
        @examples = []
        nt_records = []

        old_examples.each do |example|
            if @examples.empty?
                @examples << example
                nt_records << [0, 0]
                next
            end

            nearest = sorted_examples_with_distances(example)[0][1]
            i = @examples.find_index(nearest)
            nt_records[i][1] += 1

            if (nearest[-1] != example[-1])
                @examples << example
                nt_records << [0, 0]
            else
                nt_records[i][0] += 1
            end
        end

        #@examples.each_with_index do |example, i|
        #    print "#{i} : "
        #    print example
        #    print " => #{nt_records[i]}"
        #    puts
        #end

        new_examples = []
        new_nt_records = []
        @examples.each_with_index do |example, i|
            accuracy = nt_records[i][0].to_f / nt_records[i][1].to_f
            if (accuracy >= @nt_drop_ratio)
                new_examples << example
                new_nt_records << nt_records[i]
            end
        end

        @examples = new_examples

        nt_records = new_nt_records
        @examples.each_with_index do |example, i|
            print "#{i} : "
            print example
            print " => #{nt_records[i]}"
            puts
        end
    end

    def calculate_feature_weighting
        all_continuous = true
        all_discrete = true

        if @attributes[0...-1].detect {|attribute| !attribute.continuous?}
          all_continuous = false
        end

        if @attributes[0...-1].detect {|attribute| attribute.continuous?}
          all_discrete = false
        end

        if all_continuous
            return calculate_feature_weighting_continuous()
        elsif all_discrete
            return calculate_feature_weighting_discrete()
        else
            puts "Haven't supported feature weighting with mixed attribute types"
            return nil
        end
    end

    def calculate_feature_weighting_discrete
        weighting = []
        @attributes[0...-1].each_with_index do |attribute, i|
            attr_class = @examples.map do |example|
                [example[i], example[-1]]
            end
            weighting << attr_class.information_gain()
        end
        return weighting
    end

    def calculate_feature_weighting_continuous
        #hash = Hash.new_array
        #@examples.each do |example|
        #    hash[example[-1]] << example
        #end

        weighting = []
        #example_t = @examples.transpose
        #example_t.dump
        @attributes[0...-1].each_with_index do |attribute, i|
            attr_class = @examples.map do |example|
                [example[i], example[-1]]
            end
            weighting << attr_class.fisher_score()

            #avg = example_t[i].avg
            #puts avg
        #    attr_class = @examples.map do |example|
        #        [example[i], example[-1]]
        #    end
        #    #weighting << attr_class.information_gain()
        end
        return weighting
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
            if sum > energy_d * @energy_ratio
                k = i
                break
            end
        end
        #puts k
        #values.dump

        vectors = value_vectors.map {|value_vector| value_vector[1]}
        vectors = vectors[0..k]
        @w = Matrix.columns(vectors)

        puts "selected eigenvectors:"
        vectors.dump
    end

    def classify(test_example)
        #byebug
        test_example = normalize(test_example)

        if @use_PCA
            test_example = transform(test_example)
        end

        e_with_d = sorted_examples_with_distances(test_example)
        sub_distances = e_with_d[0...@k]
        #print test_example
        #puts
        #sub_distances.dump

        if @is_weighted
            hash = Hash.new(0.0)
            sub_distances.each do |distance|
                hash[distance[1][-1]] += (1.0 / (distance[0] ** 2))
            end
            return hash.max_by { |k, v| v }[0]
        else
          result = sub_distances.map do |distance|
              distance[1][-1]
          end.majority
        end
        #puts
        #puts " => #{distances[0][1]}"
        #distances.dump
        #return distances[0][1]
        return result
    end

    def sorted_examples_with_distances(test_example)
        examples_with_distances = @examples.map do |example|
            [distance(example, test_example), example]
        end.sort_by do |example_with_distance|
            example_with_distance[0]
        end
    end

    def distance(example1, example2)
        sum = 0.0
        @attributes[0...-1].each_with_index do |attribute, i|
            inc = 0.0
            if attribute.continuous?
                inc = (example1[i].to_f - example2[i].to_f) ** 2
            else
                if (example1[i] != example2[i])
                    inc = 1
                end
            end

            #if @use_feature_weighting
            if @feature_weighting
                inc *= @feature_weighting[i]
            end

            sum += inc
        end
        Math.sqrt(sum)
    end

    def add_record(record)
        if @use_ntgrowth
            record["NTGrowth"] = @examples.length
        end
    end
end
