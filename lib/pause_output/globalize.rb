# coding: utf-8

#Monkey patches for pause output global entities.
class Object

  private

  # Execute a block with page paused output.
  def more(options={})
    saved = $stdout
    outer = $stdout.equal?($pause_output_out)

    enabled = options[:page_pause]
    enabled = enabled.downcase if enabled.is_a?(String)

    unless [false, 'false', 'off', 'no'].include?(enabled)
      $stdout = ::PauseOutput::OutputPager.new(options) if outer
    end

    yield

  rescue PauseOutputStop
    raise unless outer
    return

  ensure
    $stdout = saved
  end

end
