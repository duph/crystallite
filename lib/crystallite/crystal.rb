
module Crystallite
	class Edge
		attr_accessor :length
	end

	class Node
		attr_accessor :edge_list
	end

	class Crystal
		attr :root

		attr :base_flakes

		attr :flakes


		def initialize dna

		end
	end
end