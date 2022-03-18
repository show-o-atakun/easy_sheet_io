# easy_sheet_io
Gem to read csv, xls, xlsx. You can convert it to 2D array, hash or data frame.

## Usage
First, you install this gem:

```bash
gem install easy_sheet_io
```

Then, you can use it like below:

```ruby
require 'easy_sheet_io'

ary = EasySheetIo.read("sample.csv")

## xls, xlsx can be designated at the same way. 
# ary = EasySheetIo.read("sample.xls")
# ary = EasySheetIo.read("sample.xlsx")
```

In this example, variable ary is a 2-dimentional array.

If you want a hash, or dataframe, format option is helpful.

```ruby
require 'easy_sheet_io'

hash = EasySheetIo.read("sample.xls", format: "hash")   ## Hash
df_d = EasySheetIo.read("sample.xls", format: "daru")   ## Daru::DataFrame
df_r = EasySheetIo.read("sample.xls", format: "rover")  ## Rover::DataFrame
```

You can designate header row number with header option.
If you want to ignore some beggining lines, you use line_from option. 

```ruby
require 'easy_sheet_io'

df = EasySheetIo.read("sample.xls", format: "rover", header: 7, line_from: 10)
```

When you set header: nil, then default header ("column1", "column2", ...) is set.
