require 'transformatrix'
require_relative 'extenders'
require_relative 'helpers'

module Crystallite
	class Flake
		include Math
		include Helpers

		attr :points
		attr :size
		attr :axes

		attr :angle
		attr :radius

		attr :flake_gene

		def initialize flake_gene
			@points = []
			@sector_points = []

			@flake_gene = flake_gene

			set_growth_vars

			sector_points_parse
			sector_points_fit_to_div
			sector_points_sort
			sector_points_scale

			points_parse_cartesian
			points_replicate

		end

		def points
			@points
		end


		#
		# Growth
		#

		private

		def set_growth_vars
			@angle = PI / @flake_gene.axes
			@radius = @flake_gene.size / 2
		end

		def sector_points_parse
			@flake_gene.sector_points.each do |point|
				@sector_points.push point.dup
			end
		end

		def sector_points_fit_to_div
			@sector_points.each do |point|
				point[0] *= @flake_gene.div_radius
				point[1] *= @flake_gene.div_alpha

				point[0] = point[0].round
				point[1] = point[1].round

				point[0] /= Float(@flake_gene.div_radius)
				point[1] /= Float(@flake_gene.div_alpha)
			end
		end

		def sector_points_sort
			@sector_points.sort_by! do |point|
				-point[1]
			end
		end

		def sector_points_scale
			@sector_points.each do |point|
				point[0] *= @radius
				point[1] *= @angle
			end
		end

		def points_replicate
			new_points = reflect_points(@points, [1,0])
			@points += new_points
			new_points = @points

			(@flake_gene.axes-1).times do |i|
				reflect_angle = -@angle - 2*i*@angle
				new_points = reflect_points(new_points, [cos(reflect_angle), sin(reflect_angle)])
				@points += new_points
			end

			@points.each do |point|
				point.swap! 0, 1
			end
		end

		def points_parse_cartesian
			@sector_points.each do |point|
				x = point[0] * cos(point[1])
				y = point[0] * sin(point[1])
				@points.push [x,y]
			end
		end
	end
end