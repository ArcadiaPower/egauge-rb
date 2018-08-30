RSpec.describe Egauge::Response do
  let(:response_body) { File.read('spec/fixtures/response.xml')  }
  let(:expected_headers) { ["solar", "solar_"] }
  let(:expected_response) {
    [
      138874,
      117644,
      93325,
      71725,
      56080,
      39718,
      24820,
      18082,
      10650,
      5038,
      0,
      0,
      0
    ]
  }
  subject { described_class.new(response_body) }

  it "should parse columns into structs" do
    expect(subject.solar).to eq(expected_response)
  end

  it "should parse headers properly" do
    expect(subject.headers).to eq(expected_headers)
  end

  it "should create reader methods for all headers" do
    expect(subject).to respond_to(:solar)
    expect(subject).to respond_to(:solar_)
  end
end
