require 'rasem'
require 'colorist'

module Crystallite
	class SVGGenerator < Rasem::SVGImage
		def write_svg path
			write_close
			File.open("#{path}/polygon_test.svg", "w") { |file| file.write(@output) }
		end
	end
end