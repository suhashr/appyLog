#this class is used to parse a single log line i.e. string manipulation to return usefel data for the log lines
class LogLineParser

  def get_response_time(log_line = "")
    service_time = get_service_time(log_line)
    (log_line.length > 0 && log_line.include?(" connect=") && service_time != nil) ? #check if log_line is present and it contains connect and service string
      log_line.split(' connect=')[1].split('ms')[0].to_i + service_time : nil #split and get the number between service= and ms and connect= and ms and add them
  end

  def get_cameraip_home(log_line = "")
    camera_ip = get_cameraip(log_line)
    (log_line.length > 0 && camera_ip != nil && log_line.include?(" home_id=")) ? #check if log_line is present and it contains ip_camera and home_id string
      [camera_ip, log_line.split(' home_id=')[1].split(' connect=')[0]] : [] #split and get ip_camera and home_id
  end

  def get_cameraip(log_line = "")
    (log_line.length > 0 && log_line.include?(" ip_camera=")) ? #check if log_line is present and it contains ip_camera string
      log_line.split(' ip_camera=')[1].split(' home_id=')[0].gsub(/\A"|"\z/,'') : nil #split and get ip_camera, gsub used to remove quotation inside quotation
  end

  def get_service_time(log_line = "")
    (log_line.length > 0 && log_line.include?(" service=")) ? #check if log_line is present and it contains service string
      log_line.split(' service=')[1].split('ms')[0].to_i : nil #split and get service time
  end

  def get_method(log_line = "")
    (log_line.length > 0 && log_line.include?(" method=")) ? #check if log_line is present and it contains method string
      log_line.split(' method=')[1].split(' path=')[0] : nil #split and get service time
  end

  def get_endpoint(log_line = "")
    (log_line.length > 0 && log_line.include?(" path=")) ? #check if log_line is present and it contains path string
      log_line.split(' path=')[1].split(' host=')[0] : nil #split and get path
  end

end
