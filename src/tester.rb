require 'json'

require "./src/data.rb"
require "./src/util.rb"
require "./src/statistics.rb"
require "./src/id3.rb"
require "./src/majority.rb"
require "./src/print.rb"

class Tester
    @@random_seed = 0
    @@num_of_round = 10
    def initialize(data_file, attr_file, setup_file = nil)
        # parse
        raw_attributes = Attribute.parse_attr_file(attr_file)
        @examples = LearningData.parse_data_file(data_file, raw_attributes.length)

        # preprocess
        @attributes = Attribute.calculate_attributes(@examples, raw_attributes)

        @examples.shuffle!(random: Random.new(@@random_seed))

        # partition
        @examples_partition = @examples.partition_n_parts(@@num_of_round)

        #setup
        if setup_file
            file = File.read(setup_file)
            @setup = JSON.parse(file)
        end
    end

    def single_run(classifier_class, i = 0)
        record = Hash.new
        record["round"] = i+1

        learning_examples = @examples_partition.merge_all_but(i)
        test_examples = @examples_partition[i]
        record["learn"] = learning_examples.length
        record["test"] = test_examples.length

        classifier = classifier_class.new(learning_examples, @attributes, @setup)

        if classifier.respond_to? :add_record
            classifier.add_record(record)
        end
        #all_record << record
        #test_examples.each do |example|
        #    res = classifier.classify(example)
        #    print example
        #    puts " -> #{res}"
        #end
        #exit
        error = test_all(classifier, test_examples)
        record["error"] = error
        
        return record
    end

    def cross_validation(classifier_class)
        all_record = []
        (0...@@num_of_round).each do |i|
            #record = Hash.new
            #record["round"] = i+1

            #learning_examples = @examples_partition.merge_all_but(i)
            #test_examples = @examples_partition[i]
            #record["learn"] = learning_examples.length
            #record["test"] = test_examples.length

            #classifier = classifier_class.new(learning_examples, @attributes)

            #if classifier.respond_to? :add_record
            #    classifier.add_record(record)
            #end
            ##all_record << record
            ##test_examples.each do |example|
            ##    res = classifier.classify(example)
            ##    print example
            ##    puts " -> #{res}"
            ##end
            ##exit
            #error = test_all(classifier, test_examples)
            #record["error"] = error
            ##puts no_of_error
            record = single_run(classifier_class, i)
            all_record << record
        end

        all_record.each do |record|
            puts record
        end
    end

    private
    def test_all(classifier, examples)
        no_of_error = 0
        examples.each do |example|
            result = classifier.classify(example)
            no_of_error += 1 if result != example[-1]
        end
        return no_of_error
    end
end
