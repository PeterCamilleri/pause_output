# coding: utf-8

#Monkey patches for pause output global entities.
class Object

  private

  # Execute a block with page paused output.
  def more(options={})
    saved = $stdout

    disabled = options[:page_pause]
    disabled = disabled.downcase if disabled.is_a?(String)

    unless [false, 'false', 'off', 'no'].include?(disabled)
      outer = $stdout.equal?($pause_output_out)
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
