# coding: utf-8

$pause_output_out = $stdout   # Keep a copy of the real $stdout.

module PauseOutput

  # A class to manage paged output.
  class OutputPager

    # Set up the initial values.
    def initialize(options={})
      @options = options
      @lines   = 0
      @chars   = 0
    end

    # Write out a general string with page pauses.
    def write(str)
      until str.empty?
        pre,mid,str = str.partition("\n")
        write_str(pre) unless pre.empty?
        writeln unless mid.empty?
      end
    end

    # Write out an object as a string.
    def <<(obj)
      write(obj.to_s)
    end

  private

    # Write out a simple string with no embedded new-lines.
    def write_str(str)
      loop do
        len = str.length

        if @chars + len < chars_per_line
          $pause_output_out.write(str)
          @chars += len
          return
        else
          tipping_point = chars_per_line - @chars
          $pause_output_out.write(str[0, tipping_point])
          count_lines

          str = (str[tipping_point..-1])
        end
      end
    end

    # Write out a new-line.
    def writeln
      $pause_output_out.write("\n")
      count_lines
    end

    # A new line is out, count it!
    def count_lines
      @chars = 0
      @lines += 1

      if @lines >= (lines_per_page - 1)
        case pause.downcase
        when one_line
          @lines -= 1
        when skip_all
          @lines = 0
          raise PauseOutputStop
        when no_pause
          @lines = -1_000_000
        else
          @lines = 0
        end
      end
    end

    # Pause waiting for the user.
    def pause
      msg = pause_message
      $pause_output_out.write(msg)

      MiniTerm.raw do |term|
        result = term.get_raw_char
        term.flush
        result
      end

    ensure
      $pause_output_out.write("\r" + " " * msg.length + "\r")
    end

    # How many lines fit on a page?
    def lines_per_page
      result = @options[:page_height].to_i
      result = MiniTerm.height if result < 2
      result
    end

    # How many characters fit on a line?
    def chars_per_line
      result = @options[:page_width].to_i
      result = MiniTerm.width if result < 20
      result
    end

    # Get the text of the pause message.
    def pause_message
      @options.key?(:page_msg) ? @options[:page_msg] :
        "Press space (line), n (no pause), q(uit) or other (page):"
    end

    # Keystroke to advance one line.
    def one_line
      @options.key?(:one_line) ? @options[:one_line] : " "
    end

    # Keystroke to quit processing.
    def skip_all
      @options.key?(:skip_all) ? @options[:skip_all] : "q"
    end

    # Keystroke to disable pauses.
    def no_pause
      @options.key?(:no_pause) ? @options[:no_pause] : "n"
    end

  end

end