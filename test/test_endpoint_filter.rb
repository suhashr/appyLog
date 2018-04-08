require_relative "../lib/endpoint_filter"
require "test/unit"

class TestEndPointFilter < Test::Unit::TestCase

  def test_endpoint_hash
    endpoint_filter = EndpointFilter.new
    assert_equal("File not found or corrupted", endpoint_filter.get_endpoint_hash('./nofile.log')) #check for no file give response of error
    endpoint_hash = endpoint_filter.get_endpoint_hash('./test/test_sample.log') #correct file_path
    assert_equal(1, endpoint_hash['get_camera'].count)
    assert_equal(4, endpoint_hash['get_all_cameras'].count)
    assert_equal(1, endpoint_hash['get_home'].count)
    assert_equal(3, endpoint_hash['post_user'].count)
    assert_equal(1, endpoint_hash['get_user'].count)
    default_file_hash = endpoint_filter.get_endpoint_hash() #if not filepath given, it will use default log File
    assert_equal(1533, default_file_hash['get_camera'].count)
  end

end
