#this class is used to parse a bunch of log lines and return them by filtering them as needed
require './lib/log_line_parser'
require './lib/measure_central'

class TotalCalculate

  def initialize
    @log_line_parser = LogLineParser.new
    @measure_central = MeasureCentral.new
  end

  def get_mean_mode_median_response_time(log_lines_array = [])
    return_hash = Hash.new
    response_time_array = []
    log_lines_array.each do |log_line|
      response_time_array << @log_line_parser.get_response_time(log_line) #creating array of response times
    end
    mean_response = @measure_central.get_mean(response_time_array) #getting mean for array
    median_response =  @measure_central.get_median(response_time_array) #getting median for array
    return_hash["mean"] = mean_response != nil ? mean_response : 0 #return 0 if nil in hash
    return_hash["mode"] = @measure_central.get_mode(response_time_array)
    return_hash["median"] = median_response != nil ? median_response : 0  #return 0 if nil in hash
    return_hash
  end

  def get_web_camera_hash(log_lines_array = [])
    return_hash = Hash.new
    camera_ip_home_array = []
    log_lines_array.each do |log_line|
      camera_ip_home_array << @log_line_parser.get_cameraip_home(log_line) #creating array of arrays of camera_ip and home_id
    end
    camera_ip_home_array.map {|k| k[1]}.uniq.map {|k| return_hash[k] = []} #initializing hash with home_id as key and [] values
    return_hash.keys.each do |home_id|
      return_hash[home_id] = camera_ip_home_array.map {|k| k[1] == home_id ? k[0] : nil}.compact
    end
    return_hash
  end

  def get_camera_service_time_hash(log_lines_array = [])
    return_hash = Hash.new
    camera_service_time_array = []
    log_lines_array.each do |log_line|
      camera_service_time_array << [@log_line_parser.get_cameraip(log_line), @log_line_parser.get_service_time(log_line).to_f] #creating array of arrays of camera_ip and service_time
    end
    all_cameras = camera_service_time_array.map {|k| k[0]} #getting all the cameras ip
    duplicate_cameras = all_cameras.group_by{ |e| e }.select { |k, v| v.size > 1 }.map(&:first) #getting an array of camera_ip that has multiple service time
    duplicate_cameras.each do |duplicate_camera|
      duplicate_camera_service_time = camera_service_time_array.map {|k| k[0] == duplicate_camera ? k[1] : nil}.compact.map {|e| [duplicate_camera, e]} #getting the array of arrays of camera_ip and service_time
      camera_service_time_array = camera_service_time_array - duplicate_camera_service_time #removing arrays of cameras which has multiple service time
      new_service_time = @measure_central.get_mean(duplicate_camera_service_time.map {|k| k[1]}) #making new service time for cameras which has multiple service times by taking its mean/average
      camera_service_time_array << [duplicate_camera,new_service_time] #adding the new average service time and camera to the camera_service_time_array for mapping later
    end
    camera_service_time_array.map {|k| k[1]}.uniq.map {|k| return_hash[k] = []} #initializing hash with service time as key
    return_hash.keys.each do |service_time|
      return_hash[service_time] = camera_service_time_array.map {|k| k[1] == service_time ? k[0] : nil}.compact
    end
    return_hash
  end

end
