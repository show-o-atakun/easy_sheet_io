# frozen_string_literal: true
require "csv"
require "roo-xls"
require "spreadsheet"
require "rover"
require "daru"
require_relative "./to_csv"
require_relative "./longest_line"
require_relative "easy_sheet_io/version"

module EasySheetIo
	class Error < StandardError; end
	
	module_function
	
	def read(path, **opt)
		return /csv$/ === path ? read_csv(path, **opt) : read_excel(path, **opt)
	end
	
	# ##Generate Array from CSV File, and convert it to Hash or DataFrame.
	# **opt candidate= line_from: 1, header: 0
	def read_csv(path, format: nil, encoding: "utf-8", col_sep: ",", **opt)
		# Get 2D Array
		begin
			csv = CSV.parse(File.open(path, encoding: encoding, &:read), col_sep: col_sep)
		rescue Encoding::InvalidByteSequenceError
			# Try Another Encoding
			puts "Fail Encoding #{encoding}. Trying cp932..."
			csv = CSV.parse(File.open(path, encoding: "cp932", &:read), col_sep: col_sep)
		end
		
		return csv if format.nil?

		# Convert Hash or DataFrame
		ans = to_hash(csv, **opt)
		return format==:hash || format=="hash" ? ans : to_df(ans, format: format)
	end

	# ##Generate Array from EXCEL File, and convert it to Hash or DataFrame.
	# **opt candidate= line_from: 1, header: 0)
	def read_excel(path, sheet_i: 0, format: nil, encoding: "utf-8", **opt)
		a2d = open_excel(path, sheet_i, encoding: encoding) # Get 2D Array
		return a2d if format.nil?
		
		ans = to_hash(a2d, **opt)
		return format==:hash || format=="hash" ? ans : to_df(ans, format: format)
	end
	
	# Convert 2d Array to Hash
	# ##header: nil -> Default Headers(:column1, column2,...) are generated.
	# line_until=nil means the data are picked up until the end line.
	def to_hash(array2d, line_from: 1, line_until: nil, header: 0, symbol_header: false)
		
		# Define Read Range------------		
		lfrom, luntil = line_from, line_until
		lf_reg, lu_reg = line_from.kind_of?(Regexp), line_until.kind_of?(Regexp)
		
		if lf_reg || lu_reg
			lines_ary = array2d.map{ _1.join "," }
			lfrom = lines_ary.find_index{ line_from === _1 } if lf_reg
			luntil = (lines_ary.length-1) - lines_ary.reverse.find_index{ line_until === _1 } if lu_reg
		end
		# -----------------------------
			
		# Define Data Array------------
		output = array2d[lfrom...luntil]
		output_transpose = output[0].zip(*output[1..])
		# -----------------------------

		# Define Header----------------
		hd = header.nil? ? [*0...(output.longest_line)].map{"column#{_1}"} : check_header(array2d[header])
		hd = hd.map { _1.intern } if symbol_header
		# -----------------------------

		# Make Hash(Header => Data Array)  
		return hd.each_with_object({}).with_index {|(hdr, hash), i| hash[hdr]=output_transpose[i]}
	end
	
	# Convert Hash to DataFrame
	def to_df(data, format: :daru)
		if format == :daru || format == "daru"
			return Daru::DataFrame.new(data)
		else #Rover
			return Rover::DataFrame.new(data)
		end
	end
	
	# ##Genarate Array from excel file
	def open_excel(path, sheet_i, encoding: "utf-8")
		if /xlsx$/ === path
			puts "Sorry, encoding option is not supported yet for xlsx file." if encoding != "utf-8"

			book = Roo::Excelx.new(path)
			s = book.sheet(sheet_i)
			
			## bottole neck
			return s.to_a

		# xls
		else
			begin
				Spreadsheet.client_encoding = encoding
				ss = Spreadsheet.open(path)
			rescue Encoding::InvalidByteSequenceError
				puts "Fail Encoding #{encoding}. Trying Windows-31J..."
				Spreadsheet.client_encoding = "Windows-31J"
				ss = Spreadsheet.open(path)
			end

			a2d = []
			ss.worksheets[sheet_i].rows.each do |row|
				a1d = []
				row.each {|cell| a1d.push cell}
				a2d.push a1d
			end

			return a2d
		end
	end

	# Fix blank or duplicated header
	def check_header(header_array)
		ans = header_array.map.with_index do |item, i|
			if item.nil?
				"column#{i}"
			elsif item.kind_of?(String)
				/^\s*$/ === item ? "column#{i}" : item.gsub(/\s+/, "")
			else
				item
			end
		end 

		dup_check = (0...(header_array.length)).group_by {|i| ans[i]}
		dup_check.each do |item, i_s|
			if i_s.length > 1
				i_s.each_with_index {|i, index_in_i_s| ans[i] = "#{ans[i]}_#{index_in_i_s}"}
			end
		end

		return ans
	end

end
