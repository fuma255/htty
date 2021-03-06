require 'htty'

# Encapsulates the _headers-request_ command.
class HTTY::CLI::Commands::HeadersRequest < HTTY::CLI::Command

  include HTTY::CLI::Display

  # Returns the name of a category under which help for the _headers-request_
  # command should appear.
  def self.category
    'Building Requests'
  end

  # Returns the help text for the _headers-request_ command.
  def self.help
    'Displays the headers of the request'
  end

  # Returns the extended help text for the _headers-request_ command.
  def self.help_extended
    'Displays the headers used for the request. Does not communicate with '    +
    "the host.\n"                                                              +
    "\n"                                                                       +
    'Headers must have unique names. When you set a header that already '      +
    "exists, its value will be changed.\n"                                     +
    "\n"                                                                       +
    "A '#{HTTY::Request::COOKIES_HEADER_NAME}' request header is marked with " +
    'a bold asterisk (it looks like a cookie). Similarly, an '                 +
    "'#{HTTY::Request::AUTHORIZATION_HEADER_NAME}' request header is marked "  +
    "with a bold mercantile symbol ('@')."
  end

  # Returns related command classes for the _headers-request_ command.
  def self.see_also_commands
    [HTTY::CLI::Commands::HeadersSet,
     HTTY::CLI::Commands::HeadersUnset,
     HTTY::CLI::Commands::HeadersUnsetAll,
     HTTY::CLI::Commands::BodyRequest,
     HTTY::CLI::Commands::Cookies,
     HTTY::CLI::Commands::HeadersResponse]
  end

  # Performs the _headers-request_ command.
  def perform
    request = session.requests.last
    headers = if request.request_method.nil?
                if request.body.to_s.length.zero?
                  request.headers false
                else
                  request.headers true
                end
              else
                request.headers
              end
    show_headers headers,
                 show_asterisk_next_to: HTTY::Request::COOKIES_HEADER_NAME,
                 show_mercantile_next_to: HTTY::Request::AUTHORIZATION_HEADER_NAME
    self
  end

end
