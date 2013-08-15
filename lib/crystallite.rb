require 'crystallite/version'
require_relative 'crystallite/flake'
require_relative 'crystallite/crystal'
require_relative 'crystallite/svg_generator'
require_relative 'crystallite/dna'

include Crystallite

require 'sinatra'



get '/' do
	svg = Crystallite::SVGGenerator.new 1000, 1000
	svg.rectangle 0,0,1000,1000,{ fill: Colorist::Color.from_rgb(200, 210, 255) }

	c = Crystal.new(CrystalGene.new)
	c.move [500,500]
	c.polygon_list.each do |polygon_points|
		svg.polygon polygon_points, { fill: Colorist::Color.from_rgb(255,255,255) }
	end
	svg.output
end