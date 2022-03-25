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

hash = EasySheetIo.read("sample.xlsx", format: "hash")   ## Hash
df_d = EasySheetIo.read("sample.xlsx", format: "daru")   ## Daru::DataFrame
df_r = EasySheetIo.read("sample.xlsx", format: "rover")  ## Rover::DataFrame
```

## Header, Ignored Lines
You can designate header row number with *header:* option.

If you want to ignore some beggining lines, you use *line_from:* option.

Similarly, option *line_until:* is for the last lines. (These options are for Hash, Dataframe only.)

You can designate regular expressions as line_from, line_until options.

```ruby
require 'easy_sheet_io'

df = EasySheetIo.read("sample.xlsx", format: "rover", header: 7, line_from: 10, line_until: 200)
df = EasySheetIo.read("sample.xlsx", format: "rover", header: 7, line_from: 10, line_until: /END OF MAIN DATA/)
```

Note that line_until option means the designated line is **not** included in output data. That is, *line_until: -1* means the last line is not included.

If you want to include the end of lines clearly, write *line_until: nil*. (Of course, it is the default setting of read method.)

### Additional features about header
When you set *header: nil*, then default headers ("column0", "column1", ...) are set.

If you want symbol headers instead of string, then set *symbol_header: true*. (Notations header: :string, header: :symbol are abolished.)

If duplicated data were found in header line, then surfix numbers are added to them (e.g. "x_0", "x_1", ...)

Moreover, if blank data or integer data were found in header line, then default headers (e.g. "column3", "column10", ...) are set so as to avoid error about data frame. These numbers (column-x) mean the positions of the columns.

## Other Options
*encoding:* option is available for reading .csv, .xls only (not supported for .xlsx) at present.

*col_sep:* option: You can designate csv separator with it.

*sheet_i:* means excel sheet to read.

*replaced_by_nil:* option: You set an array containing string values as this argument. The values in data file matching with items in this array are replaced by nil. (When format is "rover", it means the values are replaced by NaN.) This option is useful to treat missing values.

*analyze_type:* option: When it is true, numerical columns are automatically converted to Integer or Float. This is experimental option (because it might be inefficient to apply to huge file) and default is false.  

## TODO

Regular expression support for header option, ignore_lines option, Numo::NArray support, method to write .xls and .xlsx

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/meshgrid. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/meshgrid/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Meshgrid project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/meshgrid/blob/master/CODE_OF_CONDUCT.md).
