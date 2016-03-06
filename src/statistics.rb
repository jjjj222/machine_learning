module Enumerable
    def mean_se
        avg = expected_value()
        variance = inject(0.0) {|sum, elt| sum += (elt - avg)**2 } / length
        se = Math.sqrt(variance)
        return [avg, se]
    end 

    def expected_value
        inject(0.0) do |sum, elt|
            sum += elt
        end / length
    end
end
