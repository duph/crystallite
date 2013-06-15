require_relative 'flake'
require_relative 'helpers'


module Crystallite
	class Crystal
		include Math
		include Helpers

		attr :crystal_gene
		attr :flake_list
		attr :polygon_list

		def initialize crystal_gene
			@crystal_gene = crystal_gene

			grow_flakes
			grow_crystal
		end

		def grow_flakes
			@flake_list = []
			@crystal_gene.each_flake_gene do |c_g|
				@flake_list.push Crystallite::Flake.new(c_g)
			end
		end

		def grow_crystal
			@polygon_list = []

			# copy center flake to points
			@polygon_list += [flake_list[0].points.dup]

			@crystal_gene.distance_list.length.times do |i|
				# position flake to perimiter
				new_points = flake_list[i+1].points.dup
				new_points = move_points(new_points, [0, -crystal_gene.distance_list[i]])

				# rotate flake around perimiter and copy to points
				@crystal_gene.axes.times do |i|
					@polygon_list += [rotate_points(new_points, i*2*PI/@crystal_gene.axes)]
				end
			end
		end

		def move position
			# TODO: test
			new_polygon_list = []
			@polygon_list.each do |polygon|
				new_polygon_list.push move_points(polygon, position)
			end
			@polygon_list = new_polygon_list
		end

		def scale scalar
			new_polygon_list = []
			@polygon_list.each do |polygon|
				new_polygon_list.push scale_points(polygon, position)
			end
			@polygon_list = new_polygon_list
		end
	end
end