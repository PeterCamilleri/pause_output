# PauseOutput

The pause_output gem provides a facility like the classic more (or less) utility
within Ruby programs. This little bit of code started out as a feature of the
mysh (my shell) program but was spun off as it was felt that this capability
had use on a larger scale.

Also included is a simple demo program called pom (Pause Output More) This
simple demo accepts a list of files and displays them, pausing as needed.
It is as easy to use as this:

    pom README.md

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'pause_output'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install pause_output

## Usage

The pause_output gem works through the more command. This simple command
accepts optional hash arguments and a block. For example:

```ruby
more do
  100.times do |i|
    puts "#{'%5d' % i}, #{'%6d' % (i*i)}, #{'%8d' % (i*i*i)}"
  end
end
```

#### Options

The following options are available for use in the optional options hash
parameter of the global Object#more method:

Option      | Values  | Default       | Description
------------|---------|---------------|----------------
:page_pause | boolean | true          | Is page pause enabled?
:page_height| integer | console height| The height of the page.
:page_width | integer | console width | The width of the page.
:page_msg   | string  | "Press space (line), n (no pause), q(uit) or other (page):" | The paused prompt message.
:one_line   | string  | " "           | The key to progress by one line.
:skip_all   | string  | "q"           | The key to skip the rest of the output.
:no_pause   | string  | "n"           | The key to display the rest with no pauses.

The default value is used if the option is absent from the hash. Unsupported
option values are ignored and have no effect.

Notes:
* Setting page_pause to false can allow a block of code to run without pausing
at page breaks, if that is desired.
* If the :page_height and :page_width values are not valid, the default values
will be used instead.
* Nesting of "more" blocks is allowed. However, only the options of the outermost
block are active. The options passed into "inner" blocks are ignored.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

OR...

* Make a suggestion by raising an
 [issue](https://github.com/PeterCamilleri/pause_output/issues)
. All ideas and comments are welcome.

## License

The gem is available as open source under the terms of the
[MIT License](./LICENSE.txt).

## Code of Conduct

Everyone interacting in the pause_output project’s codebases, issue trackers,
chat rooms and mailing lists is expected to follow the
[code of conduct](./CODE_OF_CONDUCT.md).
