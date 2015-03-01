$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'active_record/destroy_as_you_like'

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

RSpec.configure do
end
