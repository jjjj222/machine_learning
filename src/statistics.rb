module Enumerable
    def mean_sd
        avg = expected_value()
        variance = inject(0.0) {|sum, elt| sum += (elt - avg)**2 } / (length - 1)
        #variance = inject(0.0) {|sum, elt| sum += (elt - avg)**2 } / length
        sd = Math.sqrt(variance)
        return [avg, sd]
    end 

    def expected_value
        inject(0.0) do |sum, elt|
            sum += elt
        end / length
    end

    alias_method :avg, :expected_value
    alias_method :mean, :expected_value

    #def avg_se_ci_95(tNv, limit = true)
    #def avg_se_ci_95(tNv, limit = false)
    def avg_se_ci_95(tNv)
        #tNv = 2.23
        avg, sd = mean_sd()
        #se = sd
        se = sd / Math.sqrt(length)
        interval_low = avg - se * tNv
        #interval_low = 0.0 if limit and interval_low < 0.0
        interval_up = avg + se * tNv
        #interval_up = 100.0 if limit and interval_up > 100.0
        interval = "(#{interval_low.round(1)}, #{interval_up.round(1)})"
        return [avg.round(1), se.round(1), interval]
    end

    def normalize!
        mean, sd = mean_sd()
        map! do |elt|
            (elt - mean) / sd
        end
    end

    def normalize_by!(mean, sd)
        map! do |elt|
            (elt - mean) / sd
        end
    end
end
