require "crystallite/version"

module Crystallite

	class Flake
		include Math

		attr :points
		attr :size
		attr :axes

		attr :sector_points
		attr :div_alpha, :div_radius
		attr :sector_alpha
		attr :sector_point_count

		def initialize size, min_points, max_points, axes
			@points = []
			@size = size
			@axes = axes

			@min_points = min_points
			@max_points = max_points
			
			@sector_points = []

			@div_alpha = 1
			@div_radius = 1

			@sector_alpha = PI / axes / 2

			@sector_point_count = rand(min_points..max_points)
			p @sector_point_count
			@sector_point_count /= axes
			p @sector_point_count
			@sector_point_count /= 4
			p @sector_point_count


			p sector_alpha
			p sector_point_count

			generate_sector
		end

		def generate
			if axes == 0
				random_generate
			elsif axes == 1
				nil
			else
				nil
			end
				
		end

		def generate_sector

			sector_point_count.times do |i|
				radius = size / 2
				radius *= rand(0..@div_radius)

				alpha = PI / 2
				alpha += sector_alpha * rand(0..@div_alpha)
				
				x = radius * cos(alpha) 
				y = radius * sin(alpha)
				
				sector_points.push([x,y])
			end
		end

		# def random_generate
		# 	points.clear
		# 	rand(@min_points..@max_points).times do
		# 		points.push([rand(0..bound_x), rand(0..bound_y)])
		# 	end
		# 	points
		# end

		def points
			@points
		end
		def sector_points
			@sector_points
		end
	end
end

f = Crystallite::Flake.new 50, 0, 50, 2
p f.sector_points