require_relative 'properties'

module Crystallite
	class FlakeGene
		attr :code

		def initialize
			@code =
			{
				size: nil,
				sector_points: [],
				axes: nil
			}
		end

		def randomize
			size = rand(Properties.Flake.min_size..Properties.Flake.max_size)
			axes = rand(Properties.Flake.min_axes..Properties.Flake.max_axes)
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