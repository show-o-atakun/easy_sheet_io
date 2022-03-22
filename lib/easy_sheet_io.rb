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
	
	# ##Generate DF from CSV File
	# **opt candidate= line_from: 1, header: 0
	def read_csv(path, format: nil, encoding: "utf-8", **opt)
		csv = CSV.parse(File.open path, encoding: encoding, &:read) # Get 2D Array
		return csv if format.nil?

		ans = to_hash(csv, **opt)
		return format==:hash || format=="hash" ? ans : to_df(ans, format: format)
	end

	# ##Generate DF from Excel File
	# **opt candidate= line_from: 1, header: 0)
	# !encoding parameter is not allowed yet
	# !(Finally, I want to make it automatically recognize encoding of file).
	def read_excel(path, sheet_i: 0, format: nil, **opt)
		a2d = open_excel(path, sheet_i) # Get 2D Array
		return a2d if format.nil?
		
		ans = to_hash(a2d, **opt)
		return format==:hash || format=="hash" ? ans : to_df(ans, format: format)
	end
	
	# Convert 2d Array to Hash
	# ##header: nil -> Default Headers(:column1, column2,...) are generated.
	def to_hash(array2d, line_from: 1, line_until: -1, header: 0)
		output = array2d[line_from..line_until]
		hd = header.nil? ? [*0...(output.longest_line)].map{"column#{_1}"} : array2d[header]
		output_transpose = output[0].zip(*output[1..])
		
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
	
	# ##Genarate Hash from excel file
	def open_excel(path, sheet_i)
		begin
			book = /xlsx$/ === path ? Roo::Excelx.new(path) : Roo::Excel.new(path)
			s = book.sheet(sheet_i)
			
			## bottole neck===
			return s.to_a
			
		rescue Encoding::InvalidByteSequenceError
		
			Spreadsheet.client_encoding="Windows-31J"
			ss = Spreadsheet.open(path)

			a2d = []
			ss.worksheets[sheet_i].rows.each do |row|
				a1d = []
				row.each {|cell| a1d.push cell}
				a2d.push a1d
			end

			return a2d
		end

	end
end
