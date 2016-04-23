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

module Enumerable
  def entropy
    hash = word_count()

    sum = 0.0
    hash.each_value do |value|
        ratio = value.to_f / length
        sum += -1 * ratio * Math.log2(ratio)
    end
    return sum
  end

  def information_gain
    sum = map {|elt| elt[-1]}.entropy()

    hash = Hash.new_array
    each do |elt|
        hash[elt[0]] << elt[1]
    end

    hash.each_value do |array|
        ratio = array.length.to_f / length
        sum -= ratio * array.entropy
    end

    return sum
  end

  def fisher_score
    avg = map {|elt| elt[0]}.expected_value()

    byebug
    hash = Hash.new_array
    each do |elt|
        hash[elt[1]] << elt[0]
    end

    numerator = 0.0
    denominator = 0.0

    hash.each_value do |values|
        mean, sd = values.mean_sd
        numerator += ((mean - avg) ** 2) * values.length
        denominator += (sd ** 2) * values.length
    end
    return numerator / denominator
  end
end
