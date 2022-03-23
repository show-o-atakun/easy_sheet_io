# frozen_string_literal: true

RSpec.describe EasySheetIo do
  # it "has a version number" do
  #   expect(EasySheetIo::VERSION).not_to be nil
  # end

  it "csv test" do
    df = EasySheetIo.read("../Test.csv", format: :daru)
    expect(df.nrows).to eq 5215
  end

  it "xls test" do
    df = EasySheetIo.read("../Test.xls", format: :daru)
    p df
    expect(df.nrows).to eq 4
  end

  it "xlsx test" do
    df = EasySheetIo.read("../Test.xlsx", format: :daru)
    p df
    expect(df.nrows).to eq 4
  end

  it "line_from, line_until option of Regexp" do
    df = EasySheetIo.read("../Test.xlsx", format: :daru, line_from: /6/, line_until: /てすと/)
    p df
    expect(df.nrows).to eq 2
  end

  it "symbol header" do
    df = EasySheetIo.read("../Test.xlsx", format: :daru, header: :symbol)
    expect(df[1].name).to eq :column1
  end
end
