require_relative 'flake'

module Crystallite
	class Crystal
		attr :crystal_gene

		attr :flake_list

		def initialize crystal_gene
			@crystal_gene = crystal_gene
			@flake_list = []

			grow_flakes
		end

		def grow_flakes
			@crystal_gene.each_flake_gene do |c_g|
				@flake_list.push Crystallite::Flake.new(c_g)
			end
		end

		
	end
end