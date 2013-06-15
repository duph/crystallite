
module Crystallite
	module Helpers
		def move_points point_list, position
			ret_points = []
			point_list.reverse_each do |point|
				ret_points.push(TMatrix.translation(position[0], position[1]) * point)
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