# require 'unicode/display_width'
require 'console'
$KCODE = 'u'

module Hirb
  # Provides string helpers to deal with UTF-8 and ruby 1.8.x
  module String

    extend self

    # :stopdoc:

    def display_width(string)
      ::Console.display_width(string)
    end

    def ljust(string, desired_length)
      leftover = desired_length - display_width(string)
      leftover > 0 ? string + " " * leftover : string
    end

    def rjust(string, desired_length)
      leftover = desired_length - display_width(string)
      leftover > 0 ? " " * leftover + string : string
    end

    def truncate(string, width)
      split_at_display_width(string, width).first
    end

    # Split the original string into 2 string.
    # The first string has most possible length but can't be longer than width
    def split_at_display_width(string, width)
      chars = string.chars.to_a
      head = ::Console.display_slice(string, 0, width+1, "")
      tail = chars[head.chars.count, chars.count].join
      [head, tail]
    end

    #:startdoc:
    #
  end
end
