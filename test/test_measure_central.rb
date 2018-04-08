require_relative "../lib/measure_central"
require "test/unit"

class TestMeasureCentral < Test::Unit::TestCase

  def test_mean
    measure_central = MeasureCentral.new()
    assert_nil(measure_central.get_mean()) #check return nil on empty arguements
    assert_equal(22.143, measure_central.get_mean([10,2,38,23,38,23,21]).round(3))
  end

  def test_mode
    measure_central = MeasureCentral.new()
    assert_equal([[],nil], measure_central.get_mode()) #check for no arguements
    assert_equal([[38, 23],2], measure_central.get_mode([10,2,38,23,38,23,21]))
  end

  def test_median
    measure_central = MeasureCentral.new()
    assert_nil(measure_central.get_median()) #check for no arquements
    assert_equal(23.0, measure_central.get_median([10,2,38,23,38,23,21]))
  end

end
