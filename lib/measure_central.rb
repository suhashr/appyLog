#this class is used for usage of calculating central tendency such as mean, mode and median
class MeasureCentral

  def get_mean( arrayVals = [] )
    (arrayVals.length > 0) ? (arrayVals.reduce(:+)/arrayVals.length.to_f) : nil #check if length is more than 0 to avoid divide by 0 error
  end

  def get_mode( arrayVals = [] )
    freq_hash = arrayVals.inject(Hash.new(0)) { |h,v| h[v] += 1; h } #creating hash of uniq array values as key and its frequency as value
    max_val = freq_hash.values.max #getting the maximum frequency
    [freq_hash.map{ |k,v| v == max_val ? k : nil }.compact, max_val] #returning array of the frequency and array of most repeated values
  end

  def get_median( arrayVals = [] )
    sorted_array = arrayVals.sort #sort arrays in ascending order
    (arrayVals.length > 0 ) ? ((sorted_array[(arrayVals.length - 1) / 2] + sorted_array[arrayVals.length / 2]) / 2.0) : nil #check length more than 0 to avoid trying to return nil array value
  end

end
