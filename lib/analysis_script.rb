require './lib/endpoint_filter'
require './lib/total_calculate'

endpoint_filter = EndpointFilter.new
total_calculate = TotalCalculate.new

hashed_lines = endpoint_filter.get_endpoint_hash('./log_file_sample/sample_appysphere.log')
hashed_lines.keys.each do |endpoint|
  puts "#{endpoint} was called #{hashed_lines[endpoint].count} times"
  web_camera_hash = total_calculate.get_web_camera_hash(hashed_lines[endpoint])
  if web_camera_hash.keys.count > 0
    web_camera_hash.keys.sort_by! {|s| s[/\d+/].to_i}.each do |home_id| #sorting by converting string to integer
      puts "#{home_id} called camera #{web_camera_hash[home_id].count} times"
    end
  else
    puts "Camera wasn't called"
  end
  mean_mode_median_hash = total_calculate.get_mean_mode_median_response_time(hashed_lines[endpoint])
  puts "mean response time: #{mean_mode_median_hash["mean"].round(2)} ms"
  puts "median response time: #{mean_mode_median_hash["median"].round(2)} ms"
  puts "mode response time: #{mean_mode_median_hash["mode"][0].count > 0 ? mean_mode_median_hash["mode"][0].join(",") : 0} ms with frequency #{mean_mode_median_hash["mode"][1] != nil ? mean_mode_median_hash["mode"][1] : 0}"
  camera_service_time_hash = total_calculate.get_camera_service_time_hash(hashed_lines[endpoint])
  puts "Camera rankings based on average service time:"
  if camera_service_time_hash.keys.count > 0
    camera_service_time_hash.keys.sort.each_with_index do |service_time, index|
      puts "#{index + 1}) #{service_time.round(2)} ms average service time for cameras:"
      puts "\t#{camera_service_time_hash[service_time].join(', ')}"
    end
  else
    puts "Camera wasn't called"
  end
  puts "\n"
end
