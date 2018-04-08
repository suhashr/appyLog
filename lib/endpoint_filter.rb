#this class is used to get the file path as input and return a hash with array of log lines as value and its endpoint type as key
require './lib/log_line_parser'

class EndpointFilter

  def initialize
    @log_line_parser = LogLineParser.new
  end

  def get_endpoint_hash(file_path = "")
    return_hash = Hash.new
    ['get_camera', 'get_home', 'get_all_cameras', 'post_user', 'get_user'].map {|k| return_hash[k] = []}
    file_path = './log_file_sample/sample_appysphere.log' if file_path.length == 0 #use default log file if filepath not provided
    begin
      File.open(file_path).each_line do |line|
        endpoint = @log_line_parser.get_endpoint(line)
        endpoint_method = @log_line_parser.get_method(line)
        if endpoint != nil && endpoint_method != nil && endpoint.start_with?('/api/users/') &&
          if endpoint.end_with?('/get_camera') && endpoint_method.downcase == 'get' #get_camera endpoint
            return_hash['get_camera'] << line
          elsif endpoint.end_with?('/get_home') && endpoint_method.downcase == 'get' #get_home endpoint
            return_hash['get_home'] << line
          elsif endpoint.end_with?('/get_all_cameras') && endpoint_method.downcase == 'get' #get_all_cameras endpoint
            return_hash['get_all_cameras'] << line
          elsif endpoint.split('/').size == 4 && endpoint.split("/").last.match(/^(\d)+$/) && endpoint_method.downcase == 'post' #user post endpoint
            return_hash['post_user'] << line
          elsif endpoint.split('/').size == 4 && endpoint.split("/").last.match(/^(\d)+$/) && endpoint_method.downcase == 'get' #user get endpoint
            return_hash['get_user'] << line
          end
        end
      end
      return_hash
    rescue => error
      "File not found or corrupted"
    end
  end

end
