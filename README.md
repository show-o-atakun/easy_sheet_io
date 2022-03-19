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
(These options are for Hash, Dataframe.)

```ruby
require 'easy_sheet_io'

df = EasySheetIo.read("sample.xls", format: "rover", header: 7, line_from: 10)
```

When you set header: nil, then default header ("column1", "column2", ...) is set.

## TODO

line_until option, regular expression support for options, Numo::NArray support, method to write .xls and .xlsx

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/meshgrid. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/meshgrid/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Meshgrid project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/meshgrid/blob/master/CODE_OF_CONDUCT.md).
