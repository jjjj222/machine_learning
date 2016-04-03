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

    alias_method :avg, :expected_value
    alias_method :mean, :expected_value

    def avg_se_ci_95(tNv)
        #tNv = 2.23
        avg, se = mean_se()
        interval_low = avg - se * tNv
        interval_low = 0.0 if interval_low < 0.0
        interval_up = avg + se * tNv
        interval_up = 100.0 if interval_up > 100.0
        interval = "(#{interval_low.round(1)}, #{interval_up.round(1)})"
        return [avg.round(1), se.round(1), interval]
    end

    def normalize!
        mean, se = mean_se()
        map! do |elt|
            (elt - mean) / se
        end
    end

    def normalize_by!(mean, se)
        map! do |elt|
            (elt - mean) / se
        end
    end
end
