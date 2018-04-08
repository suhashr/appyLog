require_relative "../lib/total_calculate"
require "test/unit"

class TestTotalCalculate < Test::Unit::TestCase

  def test_get_mean_mode_median_response_time
    total_calculate = TotalCalculate.new
    log_lines_array = []
    File.open('./test/test_sample.log').each_line do |line|
      log_lines_array << line
    end
    mean_mode_median_hash = total_calculate.get_mean_mode_median_response_time(log_lines_array)
    assert_equal(57.36, mean_mode_median_hash["mean"].round(2))
    assert_equal([[364, 21, 57, 84, 40, 67, 33, 13, 28, 27, 9, 16, 18, 26],1], mean_mode_median_hash["mode"])
    assert_equal(27.5, mean_mode_median_hash["median"])
    mean_mode_median_hash_empty = total_calculate.get_mean_mode_median_response_time() #for no arguements provided
    assert_equal(0, mean_mode_median_hash_empty["mean"].round(2))
    assert_equal([[],nil],mean_mode_median_hash_empty["mode"])
    assert_equal(0, mean_mode_median_hash_empty["median"].round(2))
  end

  def test_get_web_camera_hash
    total_calculate = TotalCalculate.new
    log_lines_array = []
    File.open('./test/test_sample.log').each_line do |line|
      log_lines_array << line
    end
    web_camera_hash = total_calculate.get_web_camera_hash(log_lines_array)
    assert_equal(4, web_camera_hash["web.12"].length)
    web_camera_hash_empty = total_calculate.get_web_camera_hash() #for no arguements provided
    assert_equal({}, web_camera_hash_empty)
  end

  def test_get_camera_service_time_hash
    total_calculate = TotalCalculate.new
    log_lines_array = []
    File.open('./test/test_sample.log').each_line do |line|
      log_lines_array << line
    end
    camera_service_time_hash = total_calculate.get_camera_service_time_hash(log_lines_array)
    assert_equal(9, camera_service_time_hash.keys.sort[0])
    assert_equal(["187.170.4.201"],camera_service_time_hash[camera_service_time_hash.keys.sort[0]])
    assert_equal(9.5, camera_service_time_hash.keys.sort[1]) #duplicate to give average
    assert_equal(["208.54.86.162"],camera_service_time_hash[camera_service_time_hash.keys.sort[1]])
    camera_service_time_hash_empty = total_calculate.get_camera_service_time_hash() #for no arguements provided
    assert_equal({}, camera_service_time_hash_empty)
  end

end
