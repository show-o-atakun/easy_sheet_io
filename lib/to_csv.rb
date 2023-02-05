require "daru"
require "rover"

class Daru::DataFrame
	def to_csv()
		a = self.to_a.transpose
		
		ans = self.map(&:name).join ","
		self.to_a[0].each do |item|
			ans += "\n"
			ans += item.map{|k, v| v}.join(",")
		end
		
		return ans
	end
	
	def write_csv(path)
		open(path, "w") { _1.write to_csv }
	end

	# To avoid bug about adding column to Daru::DataFrame
	def add_vector(vecname, vec)
		self[vecname] = vec
		self.rename_vectors({vecname => vecname})
	end

	alias_method :addvec, :add_vector
end

class Rover::DataFrame
	# Rover#to_csv is already exist.

	def write_csv(path)
		open(path, "w") {|f| f.write self.to_csv}
	end
end
