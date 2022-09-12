require 'clockwork'
require 'active_support/time'

require_relative '../config/boot'
require_relative '../config/environment'

module Clockwork
  handler do |job|
    puts "Running #{job}"
  end

  # TODO put workers here
end
