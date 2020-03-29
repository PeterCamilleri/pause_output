require_relative '../lib/pause_output'
gem              'minitest'
require          'minitest/autorun'

class PauseOutputTest < Minitest::Test

  def test_that_it_has_a_version_number
    refute_nil(::PauseOutput::VERSION)
    assert(::PauseOutput::VERSION.frozen?)
    assert(::PauseOutput::VERSION.is_a?(String))
    assert(/\A\d+\.\d+\.\d+/ =~ ::PauseOutput::VERSION)
  end

  def test_that_it_has_a_description
    refute_nil(::PauseOutput::DESCRIPTION)
    assert(::PauseOutput::DESCRIPTION.frozen?)
    assert(::PauseOutput::DESCRIPTION.is_a?(String))
  end

  def test_that_it_has_an_other_stuff_too
    refute_nil(PauseOutputStop)
    refute_nil(::PauseOutput::OutputPager)
  end

end
