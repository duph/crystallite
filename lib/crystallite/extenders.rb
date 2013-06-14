class Array
	def swap! i, j
		self[i], self[j] = self[j], self[i]
	end
end

class Numeric
	def round
	    return (self+0.5).floor if self > 0.0
	    return (self-0.5).ceil  if self < 0.0
	    return 0    
	end
end