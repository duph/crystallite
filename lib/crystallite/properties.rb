require 'yaml'
require 'hashie'

module Crystallite
	Properties = Hashie::Mash.new YAML.load_file('/Users/fpfostvedt/dev/gems/crystallite/lib/crystallite/properties.yml')
end