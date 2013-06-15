require 'crystallite/version'
require_relative 'crystallite/flake'
require_relative 'crystallite/crystal'
require_relative 'crystallite/svg_generator'
require_relative 'crystallite/dna'



width = 1000
height = 1000

f_g = Crystallite::FlakeGene.new
c_g = Crystallite::CrystalGene.new

f = Crystallite::Flake.new f_g
c = Crystallite::Crystal.new c_g
c.move([width/2, height/2])
# p "sector points: #{f.sector_points}"



svg = Crystallite::SVGGenerator.new width, height
svg.rectangle 0,0,width,height,{ fill: Colorist::Color.from_rgb(200, 210, 255) }
# svg.circle size/2,size/2,size/2, { fill: Colorist::Color.from_hsv(340, 0.1, 0.7) }

# svg.line size,size,0,0
# svg.line 0,size,size,0
# svg.line size/2,0,size/2,size
# svg.line 0,size/2,size,size/2


# svg.polygon f.points, { fill: Colorist::Color.from_rgb(255,255,255) }
c.polygon_list.each do |polygon_points|
	svg.polygon polygon_points, { fill: Colorist::Color.from_rgb(255,255,255) }
end

svg.write_svg '/Users/fpfostvedt/dev/gems/crystallite'