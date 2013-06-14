require 'crystallite/version'
require_relative 'crystallite/flake'
require_relative 'crystallite/svg_generator'
require_relative 'crystallite/dna'


size = 600

g = Crystallite::FlakeGene.new

f = Crystallite::Flake.new size, 30, 50, 2, g
puts g.code
# p "sector points: #{f.sector_points}"

svg = Crystallite::SVGGenerator.new size, size
svg.rectangle 0,0,size,size,{ fill: Colorist::Color.from_hsv(340, 0.1, 0.9) }
svg.circle size/2,size/2,size/2, { fill: Colorist::Color.from_hsv(340, 0.1, 0.7) }

svg.line size,size,0,0
svg.line 0,size,size,0
svg.line size/2,0,size/2,size
svg.line 0,size/2,size,size/2


svg.polygon f.points
svg.write_svg '/Users/fpfostvedt/dev/gems/crystallite'