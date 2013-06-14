require 'hashie'
require_relative 'properties'

module Crystallite
	class FlakeGene
		attr :code

		def initialize
			@code = 
			{
				size: nil,
				axes: nil,
				div_alpha: nil,
				div_radius: nil,
				sector_points: []
			}
			randomize
			self
		end

		def randomize
			@code[:size] = rand(Properties.Flake.min_size..Properties.Flake.max_size)
			@code[:axes] = rand(Properties.Flake.min_axes..Properties.Flake.max_axes)
			@code[:div_alpha] = rand(Properties.Flake.min_div_alpha..Properties.Flake.max_div_alpha)
			@code[:div_radius] = rand(Properties.Flake.min_div_radius..Properties.Flake.max_div_radius)
			rand(Properties.Flake.min_sector_points..Properties.Flake.max_sector_points).times do
				@code[:sector_points].push [rand(0.0..1.0), rand(0.0..1.0)]
			end
		end

		def sort_points!
			@points.sort_by! do |p|
				- point_acos(p)
			end
		end

	end

	class Dna
		attr :flake_genes

		def initialize
			@genes = {
				flakes: []
				
			}

		end

		def randomize

		end

		def mutate
		end
	end
end