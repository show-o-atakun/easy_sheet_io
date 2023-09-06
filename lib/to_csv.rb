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
	
	def write_csv(path, encoding: nil)
		enc = encoding.nil? ? "" : ":#{encoding}"
		open(path, "w#{enc}") { _1.write to_csv }
	end

	# To avoid bug about adding column to Daru::DataFrame
	def add_vector(vecname, vec)
		self[vecname] = vec
		self.rename_vectors({vecname => vecname})
	end

	# vector_i番目のヘッダー名を読めるようにエンコード
	def encode_vector_name(vector_i)
		self.vectors.to_a[vector_i].encode Encoding::UTF_8, Encoding::Windows_31J
	end
  
	# すべての列に対し実施
	def encode_vectors
		self.vectors = Daru::Index.new(Range.new(0, self.vectors.size-1).map {|i| encode_vector_name i })
	end

	# ver.0.3.8~ Convert Daru::DF encoding
	def convert_enc!(from: "cp932", to: "utf-8")
		self.vectors.each do |col|
			self[col] = self[col].each {|val| val.encode!(to, from_encoding: from) if val.is_a?(String)}
		end
	end


	alias_method :addvec, :add_vector
end

class Rover::DataFrame
	# Rover#to_csv is already exist.

	def write_csv(path, encoding: nil)
		enc = encoding.nil? ? "" : ":#{encoding}"
		open(path, "w#{enc}") {|f| f.write self.to_csv}
	end
end
