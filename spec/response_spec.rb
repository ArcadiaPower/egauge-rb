RSpec.describe Egauge::Response do
  let(:response_body) { File.read('spec/fixtures/response.xml')  }
  let(:expected_headers) { ["solar", "solar_"] }
  let(:expected_response) {
    [
      146158283881,
      146158334251,
      146139983084,
      146068891892,
      145967526663,
      145895414357,
      145824091114,
      145722749858,
      145615723358,
      145514176355,
      145432974988,
      145374099621,
      145339765044,
      145329447035,
      145329653946,
      145329861077,
      145330068247,
      145330275945,
      145330483749,
      145330691769,
      145330900190,
      145331108645,
      145331317289,
      145331525489
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
