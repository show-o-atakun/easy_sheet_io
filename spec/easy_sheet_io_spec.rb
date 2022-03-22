# frozen_string_literal: true

RSpec.describe EasySheetIo do
  it "has a version number" do
    expect(EasySheetIo::VERSION).not_to be nil
  end

  it "csv test" do
    df = EasySheetIo.read("../Test.csv", format: :daru)
    expect(df.nrows).to eq 5215
  end

  # it "csv encoding test" do
  # it "xls test" do
  # it "xls encoding test" do
  # it "header" do 
  # it "line_from" do (include regexp)
  # it "line_until" do (include regexp)
  
end
