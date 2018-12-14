require_relative '../lib/pause_output'
gem              'minitest'
require          'minitest/autorun'
require          'minitest_visible'

class PauseOutputTest < Minitest::Test

  #Track mini-test progress.
  include MinitestVisible

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

end
