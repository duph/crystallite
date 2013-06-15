require 'hashie'
require_relative 'properties'

module Crystallite
	class FlakeGene
		attr :size
		attr_accessor :axes
		attr :div_alpha
		attr :div_radius
		attr :sector_points

		def initialize			
			randomize
			self
		end

		def randomize
			@size = rand(Properties.Flake.min_size..Properties.Flake.max_size)
			@axes = rand(Properties.Flake.min_axes..Properties.Flake.max_axes)
			@div_alpha = rand(Properties.Flake.min_div_alpha..Properties.Flake.max_div_alpha)
			@div_radius = rand(Properties.Flake.min_div_radius..Properties.Flake.max_div_radius)

			@sector_points = []
			rand(Properties.Flake.min_sector_points..Properties.Flake.max_sector_points).times do
				@sector_points.push [rand(0.0..1.0), rand(0.0..1.0)]
			end
		end

	end

	class CrystalGene
		attr :flake_gene_list
		attr :distance_list
		attr :axes

		def initialize
			randomize
			self
		end

		def randomize
			@flake_gene_list = []
			Properties.Crystal.flake_gene_count.times do
				@flake_gene_list.push FlakeGene.new
			end
			@flake_gene_list[0].axes = Properties.Crystal.axes

			@distance_list = []
			(Properties.Crystal.flake_gene_count-1).times do
				@distance_list.push rand(Properties.Crystal.min_distance..Properties.Crystal.max_distance)
			end
			@distance_list.sort!

			@axes = Properties.Crystal.axes
		end

		def each_flake_gene
			@flake_gene_list.each do |f_g|
				yield f_g
			end
		end
	end
end