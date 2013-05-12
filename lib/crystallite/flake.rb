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

			@div_alpha = 2
			@div_radius = 5

			@sector_alpha = PI / axes / 2
			

			@sector_point_count = rand(min_points..max_points)
			@sector_point_count /= axes
			@sector_point_count /= 4
			
			print_debug
			generate_sector
		end

		def print_debug
			p inspect
			p "sector_alpha / PI = #{@sector_alpha/PI}"
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
				radius /= rand(1..@div_radius)

				alpha = sector_alpha / div_alpha * rand(0..@div_alpha)
				
				x = size/2 + radius * cos(alpha) 
				y = size/2 + radius * sin(alpha)
				
				p "alpha / PI: #{alpha / PI}, radius: #{radius}, point: [#{x}, #{y}]"

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