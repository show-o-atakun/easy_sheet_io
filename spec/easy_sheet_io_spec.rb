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
    df = EasySheetIo.read("../Test.xlsx", format: :daru, header: nil, symbol_header: true)
    p df.map { _1.name }
    expect(df[1].name).to eq :column1
  end

  it "header check" do
    df = EasySheetIo.read("../curious_header.csv", format: :daru, symbol_header: true)
    p df
    p df.map { _1.name }
  end
  
  it "type recognition" do
    df = EasySheetIo.read("../type_recognition.csv", format: :daru, symbol_header: true, analyze_type: true)
    p df
    expect(df[2][0].kind_of?(Float)).to eq true
  end

  it "long csv" do
    df = EasySheetIo.read("../long_csv.csv", format: :daru,
     symbol_header: true, replaced_by_nil: [" No Data", " Untest", "NaN"], analyze_type: true)
    p df.mean
  end
end
