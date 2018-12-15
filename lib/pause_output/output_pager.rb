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
      while !str.empty?
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
          tilt = chars_per_line - @chars
          $pause_output_out.write(str[0, tilt])
          count_lines

          str = (str[tilt..-1])
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
        when " "
          @lines -= 1
        when "q"
          raise PauseOutputStop
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
      @options.key?(:page_msg) ? @options[:page_msg] : "Press enter, space or q:"
    end

  end

end