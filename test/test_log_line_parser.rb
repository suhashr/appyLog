require_relative "../lib/log_line_parser"
require "test/unit"

class TestLogLineParser < Test::Unit::TestCase

  def test_response_time
    log_line_parser = LogLineParser.new()
    assert_nil(log_line_parser.get_response_time()) #check return nil on empty arguements
    log_line = "2014-01-09T06:16:54.027335+00:00 heroku[router]: at=info method=GET path=/api/users/1770684197/get_camera host=services.appysphere.com ip_camera=\"74.139.217.81\" home_id=web.7 connect=1ms service=106ms status=200 bytes=27398"
    assert_equal(107, log_line_parser.get_response_time(log_line))
  end

  def test_cameraip_home
    log_line_parser = LogLineParser.new()
    assert_equal([],log_line_parser.get_cameraip_home()) #check return nil on empty arguements
    log_line = "2014-01-09T06:16:54.027335+00:00 heroku[router]: at=info method=GET path=/api/users/1770684197/get_camera host=services.appysphere.com ip_camera=\"74.139.217.81\" home_id=web.7 connect=1ms service=106ms status=200 bytes=27398"
    assert_equal(["74.139.217.81","web.7"], log_line_parser.get_cameraip_home(log_line))
  end

  def test_cameraip
    log_line_parser = LogLineParser.new()
    assert_nil(log_line_parser.get_cameraip()) #check return nil on empty arguements
    log_line = "2014-01-09T06:16:54.027335+00:00 heroku[router]: at=info method=GET path=/api/users/1770684197/get_camera host=services.appysphere.com ip_camera=\"74.139.217.81\" home_id=web.7 connect=1ms service=106ms status=200 bytes=27398"
    assert_equal("74.139.217.81", log_line_parser.get_cameraip(log_line))
  end

  def test_service_time
    log_line_parser = LogLineParser.new()
    assert_nil(log_line_parser.get_service_time()) #check return nil on empty arguements
    log_line = "2014-01-09T06:16:54.027335+00:00 heroku[router]: at=info method=GET path=/api/users/1770684197/get_camera host=services.appysphere.com ip_camera=\"74.139.217.81\" home_id=web.7 connect=1ms service=106ms status=200 bytes=27398"
    assert_equal(106, log_line_parser.get_service_time(log_line))
  end

  def test_get_method
    log_line_parser = LogLineParser.new()
    assert_nil(log_line_parser.get_method()) #check return nil on empty arguements
    log_line = "2014-01-09T06:16:54.027335+00:00 heroku[router]: at=info method=GET path=/api/users/1770684197/get_camera host=services.appysphere.com ip_camera=\"74.139.217.81\" home_id=web.7 connect=1ms service=106ms status=200 bytes=27398"
    assert_equal("GET", log_line_parser.get_method(log_line))
  end

  def test_endpoint
    log_line_parser = LogLineParser.new()
    assert_nil(log_line_parser.get_endpoint()) #check return nil on empty arguements
    log_line = "2014-01-09T06:16:54.027335+00:00 heroku[router]: at=info method=GET path=/api/users/1770684197/get_camera host=services.appysphere.com ip_camera=\"74.139.217.81\" home_id=web.7 connect=1ms service=106ms status=200 bytes=27398"
    assert_equal("/api/users/1770684197/get_camera", log_line_parser.get_endpoint(log_line))
  end

end
