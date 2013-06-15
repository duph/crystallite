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

			(crystal_gene.distance_list.length-1).times do |i|
				i += 1
				# position flake to perimiter
				new_points = flake_list[i].points.dup
				new_points = move_points(new_points, [0, -crystal_gene.distance_list[i]])

				# rotate flake around perimiter and copy to points
				5.times do |i|
					@polygon_list += [rotate_points(new_points, i*2*PI/5)]
				end
			end
		end

		def move position
			# TODO: test
			polygon_list.each do |polygon|
				polygon = move_points(polygon, position)
			end
		end
	end
end