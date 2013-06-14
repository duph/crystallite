require 'transformatrix'
require_relative 'extenders'

module Crystallite
	class Flake
		include Math

		attr :points
		attr :size
		attr :axes

		attr :new_points

		attr :div_alpha, :div_radius
		attr :angle
		attr :sector_point_count

		attr :flake_gene

		def initialize size, min_points, max_points, axes, flake_gene
			@points = []
			@sector_points = []

			@flake_gene = flake_gene
			p flake_gene

			set_growth_vars

			sector_points_parse
			sector_points_fit_to_div
			sector_points_sort
			sector_points_scale

			points_parse_cartesian
			# points_sort
			p points
			points_replicate
			p points
			# generate_flake_points
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

		def sector_points_sort
			@sector_points.sort_by! do |point|
				-point[1]
			end
		end

		def points_replicate
			@new_points = reflect_points(@points, [1,0])
			@points += @new_points
			@new_points = @points

			(@flake_gene.axes-1).times do |i|
				reflect_angle = -@angle - 2*i*@angle
				@new_points = reflect_points(@new_points, [cos(reflect_angle), sin(reflect_angle)])
				@points += @new_points
			end

			@points.each do |point|
				point[0] += @flake_gene.size/2
				point[1] += @flake_gene.size/2
				point.swap! 0, 1
			end
		end


		def points
			@points
		end


		private

		# Point evaluators

		def point_acos point
			ret = acos(point[0]/Vector[point[0],point[1]].r)
			if ret < 0 then raise "Small" end
			if ret > PI then raise "Large" end
			ret
		end

		def point_radius point
			Vector[point[0],point[1]].r
		end


		#
		# Growth
		#

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

		def sector_points_scale
			@sector_points.each do |point|
				point[0] *= @radius
				point[1] *= @angle
			end
		end

		def points_parse_cartesian
			@sector_points.each do |point|
				x = point[0] * cos(point[1])
				y = point[0] * sin(point[1])
				@points.push [x,y]
			end
		end

		#
		# Utilities
		#

		def reflect_points point_list, axis
			ret_points = []
			point_list.reverse_each do |point|
				ret_points.push(TMatrix.reflection(axis[0], axis[1]) * point)
			end
			ret_points
		end

		def rotate_points point_list, angle
			ret_points = []
			point_list.each do |point|
				ret_points.push (TMatrix.rotation(angle) * point)
			end
			ret_points
		end

		
	end
end