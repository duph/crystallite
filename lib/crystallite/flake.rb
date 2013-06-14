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
		attr :sector_alpha
		attr :sector_point_count

		attr :flake_gene

		def initialize size, min_points, max_points, axes, flake_gene
			@points = []
			@size = size
			@axes = axes

			@min_points = min_points
			@max_points = max_points
			
			# @sector_points = []

			@div_alpha = 4
			@div_radius = 4

			@sector_alpha = PI / axes
			
			@sector_point_count = rand(min_points..max_points)
			@sector_point_count /= axes
			@sector_point_count /= 4

			@flake_gene = flake_gene

			generate_points
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

		def p_debug
			puts "@points: #{@points}"
			puts ""
			puts "@new_points: #{@new_points}"
			puts ""
		end

		def generate_points
			@new_points = initial_points
			
			@new_points.sort_by! do |point|
				-point_acos(point)
			end

			@new_points += reflect_points(@new_points, [1,0])
			@points += @new_points

			(@axes-1).times do |i|
				angle = -@sector_alpha - 2*i*@sector_alpha

				# puts "angle/PI:#{angle/PI} cos:#{cos(angle)} sin:#{sin(angle)}"

				@new_points = reflect_points(@new_points, [cos(angle), sin(angle)])
				@points += @new_points
			end

			@points.each do |point|
				point[0] += @size/2
				point[1] += @size/2
				point.swap! 0, 1
			end
		end


		def sort_points!
			@points.sort_by! do |p|
				- point_acos(p)
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
		# Pointlist generators
		#

		def initial_points
			ret_points = []

			sector_point_count.times do |i|
				radius = @size / 2
				radius /= rand(1..@div_radius)

				alpha = sector_alpha / div_alpha * rand(0..@div_alpha)
				
				x = radius * cos(alpha) 
				y = radius * sin(alpha)
				
				# p "alpha / PI: #{alpha / PI}, radius: #{radius}, point: [#{x}, #{y}]"

				ret_points.push([x,y])
			end
			ret_points
		end

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